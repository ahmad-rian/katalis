<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateBeasiswasTable extends Migration
{
    /**
     * Jalankan migration.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('beasiswas', function (Blueprint $table) {
            $table->id(); // Primary key
            $table->string('nama_beasiswa'); // Nama beasiswa
            $table->text('deskripsi'); // Deskripsi beasiswa
            $table->string('jenis'); // Jenis beasiswa
            $table->string('gambar')->nullable(); // Gambar (opsional)
            $table->timestamps(); // Kolom created_at & updated_at
        });
    }

    /**
     * Rollback migration.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('beasiswas');
    }
}