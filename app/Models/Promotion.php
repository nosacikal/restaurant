<?php

namespace App\Models;

use CodeIgniter\Model;

class Promotion extends Model
{
    protected $db;

    public function getAllPromotion()
    {
        $builder = $this->db->table('ref_promotions prom');

        $builder->select([
            'prom.id_promotion AS item_id',
            'prom.promotion_name AS item_name',
            "'No Variant' AS variant",
            'prom.price',
            "'Promo' AS category_name",
            "'Promotion' AS item_type",
            "1 AS is_promotion"
        ]);

        $builder->orderBy('category_name, item_name, variant');

        $query = $builder->get();
        return $query->getResult();
    }
}
