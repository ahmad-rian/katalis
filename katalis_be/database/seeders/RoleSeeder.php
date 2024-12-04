<?php

namespace Database\Seeders;

use Spatie\Permission\Models\Role;
use Illuminate\Database\Seeder;

class RoleSeeder extends Seeder
{
    public function run()
    {
        Role::create(['name' => 'admin']);
        Role::create(['name' => 'user']);
    }
}
