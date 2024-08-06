<?php

namespace App\Models;

use CodeIgniter\Model;

class Order extends Model
{
    protected $table            = 'tr_orders';
    protected $primaryKey       = 'id_order';
    protected $useAutoIncrement = true;
    protected $allowedFields    = ['id_table', 'order_date'];

    public function getOrderById($orderId)
    {
        return $this->select('tr_orders.id_order, 
                tr_orders.order_date, ref_table.table_number')
            ->join('ref_table', 'ref_table.id_table = tr_orders.id_table')
            ->find($orderId);
    }
}
