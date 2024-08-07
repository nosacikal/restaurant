<?php

namespace App\Models;

use CodeIgniter\Model;

class Promotion extends Model
{
    protected $db;
    protected $table            = 'ref_promotions as promotions';
    protected $primaryKey       = 'id_promotion';
    protected $useAutoIncrement = true;
    protected $allowedFields    = [];

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

    public function getPromotionsProductByIdPromotion($idPromotion)
    {
        return $this
            ->join(
                'ref_promotion_items as promotion_items',
                'promotion_items.id_promotion = promotions.id_promotion'
            )
            ->join(
                'ref_products as products',
                'products.id_product = promotion_items.id_product'
            )
            ->whereIn('promotions.id_promotion', $idPromotion)->findAll();
    }
}
