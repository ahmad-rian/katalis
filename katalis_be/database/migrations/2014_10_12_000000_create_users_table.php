<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('email')->unique();
            $table->timestamp('email_verified_at')->nullable();
            $table->string('password')->nullable(); // Buat nullable karena user Google mungkin tidak punya password
            $table->string('google_id')->nullable()->unique(); // Tambahkan unique
            $table->string('avatar')->nullable();
            $table->string('provider')->nullable(); // Tambahkan provider (google, email, dll)
            $table->string('provider_token')->nullable(); // Untuk menyimpan access token
            $table->timestamp('last_login_at')->nullable(); // Track last login
            $table->rememberToken();
            $table->timestamps();

            // Tambahkan index untuk pencarian yang lebih cepat
            $table->index(['email', 'google_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('users');
    }
};
