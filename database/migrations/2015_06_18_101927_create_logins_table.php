<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateLoginsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('logins',function(Blueprint $table){
                $table->increments('id');
                $table->integer('member_id')->unsigned();
                $table->foreign('member_id')->references('id')->on('members');
                $table->rememberToken();
                $table->enum('status',['1','0']);
                $table->string('login_from');
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
        Schema::drop('logins');
    }
}
