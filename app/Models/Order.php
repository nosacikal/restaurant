<?php

namespace App\Models;

use CodeIgniter\Model;

class Order extends Model
{
    protected $table            = 'tr_orders';
    protected $primaryKey       = 'id_order';
    protected $useAutoIncrement = true;
    protected $allowedFields    = ['id_table', 'order_date'];
}
