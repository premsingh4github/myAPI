<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateStockTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
     public function up()
    {
        Schema::dropIfExists('stocks');
        Schema::create('stocks',function(Blueprint $table){
                $table->increments('id');
                $table->integer('branchId');
                $table->integer('productTypeId');
                $table->string('lot');
                $table->string('minQuantity');
                $table->string('onlineQuantity');
                $table->float('deliveryCharge');
                $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::drop('stocks');
    }
}
