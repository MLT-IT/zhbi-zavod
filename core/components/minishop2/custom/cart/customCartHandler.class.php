<?php
if (!class_exists('msCartInterface')) {
    require_once dirname(dirname(dirname(__FILE__))) . '/model/minishop2/mscarthandler.class.php';
}

class customCartHandler extends msCartHandler implements msCartInterface {

    /**
     * @param int $id
     * @param int $count
     * @param array $options
     *
     * @return array|string
     */
    public function add($id, $count = 1, $options = []) {
        if (empty($id) || !is_numeric($id)) {
            return $this->error('ms2_cart_add_err_id');
        }
        $count = floatval($count);
        if (is_string($options)) {
            $options = json_decode($options, true);
        }
        if (!is_array($options)) {
            $options = [];
        }

        $filter = ['id' => $id];
        if (!$this->config['allow_deleted']) {
            $filter['deleted'] = 0;
        }
        if (!$this->config['allow_unpublished']) {
            $filter['published'] = 1;
        }
        /** @var msProduct $product */
        if ($product = $this->modx->getObject('modResource', $filter)) {
            if (!($product instanceof msProduct)) {
                return $this->error('ms2_cart_add_err_product', $this->status());
            }
            if ($count > $this->config['max_count'] || $count <= 0) {
                return $this->error('ms2_cart_add_err_count', $this->status(), ['count' => $count]);
            }

            /* You can prevent add of product to cart by adding some text to $modx->event->_output
              <?php
                    if ($modx->event->name = 'msOnBeforeAddToCart') {
                        $modx->event->output('Error');
                    }

            // Also you can modify $count and $options variables by add values to $this->modx->event->returnedValues
                <?php
                      if ($modx->event->name = 'msOnBeforeAddToCart') {
                        $values = & $modx->event->returnedValues;
                        $values['count'] = $count + 10;
                        $values['options'] = array('size' => '99');
                    }
            */

            $response = $this->ms2->invokeEvent('msOnBeforeAddToCart', [
                'product' => $product,
                'count' => $count,
                'options' => $options,
                'cart' => $this,
            ]);
            if (!($response['success'])) {
                return $this->error($response['message']);
            }
            $price = $product->getPrice();
            $weight = $product->getWeight();
            $count = $response['data']['count'];
            $options = $response['data']['options'];

            $key = md5($id . $price . $weight . (json_encode($options)));
            if (array_key_exists($key, $this->cart)) {
                return $this->change($key, $this->cart[$key]['count'] + $count);
            } else {
                $this->cart[$key] = [
                    'id' => $id,
                    'price' => $price,
                    'weight' => $weight,
                    'count' => $count,
                    'options' => $options,
                    'ctx' => $this->modx->context->get('key'),
                ];
                $response = $this->ms2->invokeEvent('msOnAddToCart', ['key' => $key, 'cart' => $this]);
                if (!$response['success']) {
                    return $this->error($response['message']);
                }

                return $this->success('ms2_cart_add_success', $this->status(['key' => $key]),
                    ['count' => $count]);
            }
        }

        return $this->error('ms2_cart_add_err_nf', $this->status());
    }

}
