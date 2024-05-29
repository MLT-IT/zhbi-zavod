<?

class Doppelganger{

    protected $MODX;
    protected $MINISHOP2;
    protected $categories_id_array;
    protected $categories_list;


    public function __construct($modx, $minishop2)
    {
        $this->MODX = $modx;
        $this->MINISHOP2 = $minishop2;
        $this->categories_id_array = [];
        $this->categories_list = [];
        echo 'Arrrgh Doppelganger is coming!';
    }

    

    //этой функцией id находим детей  
    public function getChildId($parent, $class){
        $modx = $this->MODX;
        $childs = [];
        $sql = "SELECT id FROM modx_site_content WHERE parent = ".$parent." AND class_key = '".$class."'";
        $statement = $modx->prepare($sql);
        if ( $statement->execute()){
            $items = $statement->fetchAll(PDO::FETCH_ASSOC);
            foreach ($items as $item){
                $childs[]=$item['id'];
            }
            
        }
        return $childs;
    }

    //получаем массив тв полей ресурса tvid => tvvalue
    public function getTvArray($id){
        $modx = $this->MODX;
        $tvs = [];
        $sql = "SELECT tmplvarid, value FROM modx_site_tmplvar_contentvalues WHERE contentid = ".$id;
        $statement = $modx->prepare($sql);
        if ( $statement->execute()){
            
                $items = $statement->fetchAll(PDO::FETCH_ASSOC);
                foreach ($items as $item){
                    $tvs[$item['tmplvarid']] = $item['value'];
                }
        }
        
        return $tvs;
    }
    public function getProductTvArray($id){
        $modx = $this->MODX;
        $tvs = [];
        $sql = "SELECT tmplvarid, value FROM modx_site_tmplvar_contentvalues WHERE contentid = ".$id;
        $statement = $modx->prepare($sql);
        if ( $statement->execute()){
            
                $items = $statement->fetchAll(PDO::FETCH_ASSOC);
                foreach ($items as $item){
                    $tvs['tv'.$item['tmplvarid']] = $item['value'];
                }
        }
        
        return $tvs;
    }

    //получаем массив опций категории
    public function getCategoryOption($id){
        $modx = $this->MODX;
        $options = [];
        $sql = "SELECT category_id, option_id FROM modx_ms2_category_options WHERE category_id = ".$id;
        $statement = $modx->prepare($sql);
        if ( $statement->execute()){
            
                $items = $statement->fetchAll(PDO::FETCH_ASSOC);
                foreach ($items as $item){
                    $options[] = $item;
                }
            
        }
        return $options;
    }



    public function copyAllCategoriesOption($from,$to){
        $modx = $this->MODX;
        $options = [];
        $sql = "SELECT * FROM modx_ms2_category_options WHERE category_id = ".$from;
        $statement = $modx->prepare($sql);
        if ( $statement->execute()){
            $items = $statement->fetchAll(PDO::FETCH_ASSOC);
            $options = $items;
            foreach($options as &$option){
                $option['category_id'] = $to;

                $sql1 = "INSERT INTO modx_ms2_category_options (`option_id`, `category_id`, `rank`, `active`, `required`, `value`) VALUES (".$option['option_id'].",".$option['category_id'].",".$option['rank'].",".$option['active'].",".$option['required'].",'".$option['value']."');";
                $statement1 = $modx->prepare($sql1);
                if ( $statement1->execute()){
                    echo 'added!';
                }
            }
            // echo '<pre>';
            // print_r($options);
            // echo '</pre>';

            
        }
        
    }


    public function createProduct($product_in,$new_parent,$ctx){
        $modx = $this->MODX;
        $product = $product_in['fields'];
        $product['parent'] = $new_parent;
        $product['context_key'] = $ctx;
        $product = array_merge($product,$product_in['tvs']);
        

        echo '<pre>';
        print_r($product);
        echo '</pre>';


        $q = $modx->newObject('modResource', $product);
        $q->save();
        $new_id = $q->id;


        echo PHP_EOL.'товар '.$product['id'].' скопирован в '.$new_parent.' c новым id: '.$new_id.PHP_EOL;

        foreach ($product_in['options'] as $key=>$value){
            $sql = "INSERT INTO modx_ms2_product_options (`product_id`, `key`, `value`) VALUES (".$new_id.",'".$key."','".$value."');";
            echo $sql.PHP_EOL;
            $statement = $modx->prepare($sql);
            if ( $statement->execute()){
                echo 'added!';
            }
        }

        
        foreach($product_in['galerey'] as $img){
            
            $galerey = [
                'id' => $new_id,
                'name' => '',
                'file' => $img
            ];
            echo '<pre>';
            print_r($galerey);
            echo '</pre>';
            if(file_exists($img)){echo 'file finded!'.PHP_EOL;}else{echo 'file NOT finded!'.PHP_EOL;}
            $upload = $modx->runProcessor('gallery/upload', $galerey, array(
                'processors_path' => MODX_CORE_PATH.'components/minishop2/processors/mgr/'
            ));
            if ($upload->isError()) {
                print_r($upload->getResponse());
            }else{
                echo 'галерея '.$product['id'].' скопирована'.PHP_EOL;
            }
        } 
    }


    public function copyCategoryProducts($from,$to,$ctx){
        $childs = $this->getChildId($from, 'msProduct');
        echo '<pre>';
        print_r($childs);
        echo '</pre>';

        foreach($childs as $child){
            $product_in = $this->getProduct($child);
            $this->createProduct($product_in,$to,$ctx);
        }
    }





    public function getProduct($id){
        $modx = $this->MODX;
        $product = $modx->getObject('msProduct', $id);
        
        $product_data =[];
        $product_data['fields'] = [
            
            'id' => $product->get('id'),
            'parent' => $product->get('parent'),
            'class_key' => 'msProduct',
            'pagetitle' => $product->get('pagetitle'),
            'longtitle' => $product->get('longtitle'),
            'alias' => $product->get('alias'),
            'description' => $product->get('description'),
            'content' => $product->get('content'),
            'template' => $product->get('template'),
            'menutitle' => $product->get('menutitle'),
            'hidemenu' => $product->get('hidemenu'),
            'published' => $product->get('published'),
            
            'article' => $product->get('article'),

            'price' => $product->get('price'),
            'old_price' => $product->get('price'),

            'vendor' => $product->get('vendor'),

            'popular' => $product->get('popular'),
            'new' => $product->get('new'),
            'favorite' => $product->get('favorite'),
        ];

        $product_data['options'] = $this->getProductOptions($id);
        $product_data['tvs'] = $this->getProductTvArray($id);
        $product_data['galerey'] = $this->getProductGalerey($id);

        // echo '<pre>';
        // print_r($product_data);
        // echo '</pre>';

        return $product_data;
    }

    public function getProductOptions($id){
        $modx = $this->MODX;
        $options = [];
        $sql = "SELECT `key`,`value` FROM modx_ms2_product_options  WHERE product_id =".$id;
        $statement = $modx->prepare($sql);
        if ( $statement->execute()){
            
                $items = $statement->fetchAll(PDO::FETCH_ASSOC);
                foreach ($items as $item){
                    $options[$item['key']] = $item['value'];
                }
            
        }
        return $options;
    }

    public function getProductGalerey($id){
        $modx = $this->MODX;
        $imgs = [];
        $sql = "SELECT url FROM modx_ms2_product_files WHERE parent = 0 AND product_id =".$id;
        $statement = $modx->prepare($sql);
        if ( $statement->execute()){
            
                $items = $statement->fetchAll(PDO::FETCH_ASSOC);
                foreach ($items as $item){
                    // $imgs[] =  "https://" . $_SERVER['HTTP_HOST'].$item['url'];
                    $imgs[] =  $_SERVER['DOCUMENT_ROOT'].$item['url'];
                }
            
        }
        return $imgs;
    }



    public function copyPhasteCategoryOptions($from,$to){
        $options = $this->getCategoryOption($from);
        foreach($options as $option){
            $opt = $option;
            $opt['category_id'] = $to;
            $res = $this->MINISHOP2->runProcessor('mgr/category/option/add', $opt);
        }
    }

    //ИМБА!
    public function copyCategoryFromParent($parent,$newparent,$ctx){
        $modx = $this->MODX;
        echo 'start';
        $ids = $this->getChildId($parent, 'msCategory');
        echo 'найдено категорий:'.count($ids).PHP_EOL;
        foreach ($ids as $id){
            $res = $modx->getObject('modResource', $id);
            $params = [
                'parent'=>$newparent,
                'context_key' => $ctx,
                'class_key' => 'msCategory', 
                'pagetitle'=>$res->get('pagetitle'),
                'alias'=>$res->get('alias'),
                'longtitle'=>$res->get('longtitle'),
                'description'=>$res->get('description'),
                'menutitle'=>$res->get('menutitle'),
                'published'=>$res->get('published'),
                'template'=>$res->get('template'),
                'content'=>$res->get('content'),
            ];
            echo '<pre>';
            print_r($params);
            echo '</pre>';
            $q = $modx->newObject('modResource', $params);
            $q->save();
    
            $new_id = $q->id;
            echo '<pre>';
            echo 'new id ='.$new_id;
            echo '</pre>';
            $tvs = $this->getTvArray($id);
            foreach($tvs as $tvid => $tvvalue){
                $q->setTVValue($tvid,$tvvalue);
            }
            $q->save();
    
            

            $this->copyAllCategoriesOption($id,$new_id);

           
        }
    }

    public function copyCategoryId($id,$newparent,$ctx,$show=false){
        $modx = $this->MODX;
        echo 'start';
        
        
        
            $res = $modx->getObject('modResource', $id);
            $params = [
                'parent'=> $newparent,
                'context_key' => $ctx,
                'class_key' => 'msCategory', 
                'pagetitle'=>$res->get('pagetitle'),
                'alias'=>$res->get('alias'),
                'longtitle'=>$res->get('longtitle'),
                'description'=>$res->get('description'),
                'menutitle'=>$res->get('menutitle'),
                'published'=>$res->get('published'),
                'template'=>$res->get('template'),
                'content'=>$res->get('content'),
            ];
            echo '<pre>';
            print_r($params);
            echo '</pre>';
            
            
            if(!$show){
                $q = $modx->newObject('modResource', $params);
                $q->save();
        
                $new_id = $q->id;
                echo '<pre>';
                echo 'new id ='.$new_id;
                echo '</pre>';
                $tvs = $this->getTvArray($id);
                foreach($tvs as $tvid => $tvvalue){
                    $q->setTVValue($tvid,$tvvalue);
                }
                $q->save();
                $options = $this->getCategoryOption($id);
                foreach($options as $option){
                    $res = $this->MINISHOP2->runProcessor('mgr/category/option/add', $option);
                    //$res = $modx->runProcessor('category/option/add', $option,['processors_path' => $modx->getOption('core_path') .'components/minishop2/processors/mgr/']);
                }
            }else{
                $tvs = $this->getTvArray($id);
                $options = $this->getCategoryOption($id);
                echo '<pre>';
                print_r($tvs);
                echo '</pre>';
                echo '<pre>';
                print_r($options);
                echo '</pre>';
            }
           
    
           
        
    }



    //ищем список id категорий каталога 
    // public function getCatalogCategoriesIds($catalog_id){
    //     $this->getChildId($catalog_id, $this->categories_id_array, 'msCategory');
    //     $non_stop=true;
    //     while($non_stop){
    //         $curr_ids=$this->categories_id_array;
    //         foreach($this->categories_id_array as $id){
    //             $this->getChildId($id, $curr_ids, 'msCategory');
    //         }
    //         $curr_ids=array_unique($curr_ids);
    //         if($this->categories_id_array==$curr_ids){
    //             $non_stop=false;
    //         }
    //         $this->categories_id_array=$curr_ids;
    //     }
    // }


    // public function getCatalogCategoriesList(){
    //     $modx = $this->MODX;
    //     foreach ($this->categories_id_array as $id){
    //         //$res = $modx->getObject('msСategory', $id);
    //         $res = $modx->getObject('modResource', $id);

    //         $options = [];

    //         $this->categories_list[]=[
    //             'id_old'=>$id,
    //             'id_parent'=>$res->get('parent'),
    //             'fields'=>[
    //                     'pagetitle'=>$res->get('pagetitle'),
    //                     'alias'=>$res->get('alias'),
    //                     'longtitle'=>$res->get('longtitle'),
    //                     'description'=>$res->get('description'),
    //                     'menutitle'=>$res->get('menutitle'),
    //                     'published'=>$res->get('published'),
    //                     'template'=>$res->get('template'),
    //                     'content'=>$res->get('content'),
    //             ],
    //             'tvs'=> $this->getTvArray($id),
    //             'options' => $this->getCategoryOption($id),
    //         ];
    //     }
    // }



    // public function showCategoriesIds(){
    //     echo '<pre>';
    //     print_r($this->categories_id_array);
    //     echo '</pre>';
    // }
    // public function showCategoriesList(){
    //     echo '<pre>';
    //     print_r($this->categories_list);
    //     echo '</pre>';
    // }
}