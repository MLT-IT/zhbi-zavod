<?php
$errors = [];
if (empty($context)) {
  $errors[] = "Необходимо передать контекст";
}

if (empty($product)) {
  $errors[] = "Необходимо передать товар";
}

if (empty($category)) {
  $errors[] = "Необходимо передать категорию";
}

if (empty($tplWrapper)) {
  $tplWrapper = "smmCharacterWrapper.tpl";
}

if (empty($tpl)) {
  $tpl = "smmCharacterItem.tpl";
}

if (!empty($errors)) {
  return implode("<br>", $errors);
}
if (!class_exists("CharactersCatalog")) {
  class CharactersCatalog
  {
    protected $modx;
    protected $product;
    protected $context;
    protected $category;
    protected $tpl;
    protected $tplWrapper;
    protected $pdoTools;

    protected array $characters;
    protected array $useKeysOptionProduct;
    protected array $productOptions;

    /**
     * @param $modx
     * @param $product
     * @param $context
     * @param $category
     */
    public function __construct($modx, $product, $context, $category, $tpl, $tplWrapper)
    {
      $this->modx = $modx;
      $this->pdoTools = $modx->getService("pdoTools");
      $this->product = $product;
      $this->context = $context;
      $this->category = $category;

      $this->tpl = $tpl;
      $this->tplWrapper = $tplWrapper;

      $this->modx->addPackage('wizard', MODX_CORE_PATH . 'components/wizard/model/');
    }

    private function get()
    {
      $query = $this->modx->newQuery("smmCharecterCatalog");
      $query->where([
        "category_id" => $this->category,
        "context" => $this->context,
      ]);
      $query->sortby('sort', 'ASC');

      $this->characters =  $this->modx->getCollection("smmCharecterCatalog", $query);

      if (count($this->characters) == 0) {
        $query = $this->modx->newQuery("smmCharecterCatalog");
        $query->where([
          "category_id" => "all",
          "context" => $this->context,
        ]);
        $query->sortby('sort', 'ASC');

        $this->characters =  $this->modx->getCollection("smmCharecterCatalog", $query);
      }

      return $this->characters;
    }

    private function getUsedKeysOptionsProducts()
    {
      $this->useKeysOptionProduct = [];
      foreach ($this->characters as $characterCatalog) {
        if (!empty($characterCatalog->option_key)) {
          $this->useKeysOptionProduct[] = "'" . $characterCatalog->option_key . "'";
        }
      }
      return $this->useKeysOptionProduct;
    }

    protected function getOptionsProduct()
    {
      $options = implode(",", $this->getUsedKeysOptionsProducts());
      if (!empty($options)) {
        $table = $this->modx->getOption('table_prefix') . 'ms2_product_options';
        $query = "SELECT *
              FROM $table
              WHERE product_id = $this->product AND `key` IN ($options)";
        $rowsOptions  = $this->modx->query($query);
        return $this->productOptions =  $rowsOptions->fetchAll(PDO::FETCH_ASSOC);
      } else {
        return  $this->productOptions = [];
      }
    }

    protected function handlerStaticValue($character)
    {
      return $character->value;
    }

    protected function handlerCustomValue($character)
    {
      if (empty($customs)) {
        $customs = $this->modx->runSnippet("dataCustomSnippet");
      }

      if (array_key_exists($character->custom, $customs)) {
        return $customs[$character->custom];
      } else {
        return "";
      }
    }

    protected function handlerOptionValue($character)
    {
      $option_key = $character->option_key;
      $option_values = array_filter($this->productOptions, function ($item) use ($option_key) {
        if ($item['key'] == $option_key) return true;
      });
      if (!empty($option_values)) {
        if (count($option_values) > 1) {
          $value = array_map(function ($item) {
            return $item['value'];
          }, $option_values);
        } else {
          $value = array_shift($option_values)['value'];
        }

        return $value;
      } else {
        return "";
      }
    }

    protected function handlerValue($character)
    {
      if ($character->value) {
        return $this->handlerStaticValue($character);
      }
      if ($character->option_key) {
        return $this->handlerOptionValue($character);
      }
      if ($character->custom) {
        return $this->handlerCustomValue($character);
      }
    }

    protected function output()
    {
      $itemsOutput = "";
      foreach ($this->characters as $characterCatalog) {
        $value = $this->handlerValue($characterCatalog);

        $dataElement['name'] = $characterCatalog->name;
        $dataElement['value'] = $value;

        $itemsOutput .= $this->pdoTools->getChunk($this->tpl, $dataElement);
      }

      return $this->pdoTools->getChunk($this->tplWrapper, ["output" => $itemsOutput]);
    }

    public function make()
    {
      $keyCache = 'properties_wizard_' . (int)$this->product;

      // пробуем взять из кэша
      $result = $this->modx->cacheManager->get($keyCache);

      // если промах (false/null) — считаем и кладём
      if ($result === false || $result === null) {
        $this->get();
        $this->getOptionsProduct();

        if (empty($this->productOptions)) {
          $result = null;
        } else {
          $result = $this->output();
        }

        $this->modx->cacheManager->set($keyCache, $result, 7200);
      }

      return $result;
    }
  }
}


$charectersCatalog = new CharactersCatalog($modx, $product, $context, $category, $tpl, $tplWrapper);
return $charectersCatalog->make();
