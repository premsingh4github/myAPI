<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateClientStockTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::dropIfExists('client_stocks');
        Schema::create('client_stocks',function(Blueprint $table){
            $table->increments('id');
            $table->integer('memberId');
            $table->integer('stockId');
            $table->integer('amount');
            $table->enum('status',['0','1','2']); // 0 = pending, 1= aproved , 2= canceled
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
        Schema::drop('client_stocks');
    }
}
