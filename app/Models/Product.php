<?php

namespace App\Models;

use CodeIgniter\Model;

class Product extends Model
{

    protected $db;

    public function getAllProduct()
    {

        $builder = $this->db->table('ref_products p');

        $builder->select([
            'p.id_product AS item_id',
            'p.product_name AS item_name',
            "COALESCE(p.variant, 'No Variant') AS variant",
            'p.price',
            'c.category_name AS category_name',
            "'Product' AS item_type",
            "0 AS is_promotion"
        ]);

        // Join with the 'ref_categories' table
        $builder->join('ref_categories c', 'p.id_category = c.id_category');

        // Execute the query and fetch the results
        $query = $builder->get();
        return $query->getResult();
    }
}
