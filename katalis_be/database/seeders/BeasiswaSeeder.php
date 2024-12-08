<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Beasiswa;

class BeasiswaSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Beasiswa::insert([
            [
                'nama_beasiswa' => 'Beasiswa Prestasi Akademik',
                'deskripsi' => 'Beasiswa untuk mahasiswa dengan pencapaian akademik terbaik.',
                'jenis' => 'Akademik',
                'gambar' => null, // Jika tidak ada gambar
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'nama_beasiswa' => 'Beasiswa Bantuan Pendidikan',
                'deskripsi' => 'Beasiswa untuk membantu mahasiswa dari keluarga kurang mampu.',
                'jenis' => 'Sosial',
                'gambar' => null, // Jika tidak ada gambar
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'nama_beasiswa' => 'Beasiswa Seni dan Budaya',
                'deskripsi' => 'Beasiswa untuk mahasiswa yang berprestasi dalam bidang seni dan budaya.',
                'jenis' => 'Seni',
                'gambar' => null, // Jika tidak ada gambar
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}