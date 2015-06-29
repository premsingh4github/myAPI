<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateMembersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('members',function(Blueprint $table){
            $table->increments('id');
            $table->string('fname');
            $table->string('mname');
            $table->string('lname');
            $table->string('address');
            $table->string('identity');
            $table->string('nationality');
            $table->string('dob');
            $table->string('ban');
            $table->string('email');
            $table->string('cNumber');
            $table->string('mNumber');
            $table->string('username');
            $table->string('password');
            $table->enum('status',['0','1','2']);
            $table->enum('mtype',['0','1','2']);
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
        Schema::drop('members');
    }
}
