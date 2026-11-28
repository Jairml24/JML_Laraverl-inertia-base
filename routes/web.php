<?php

use App\Http\Controllers\ProfileController;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

Route::middleware('auth')->group(function () {
    Route::get('/inicio', fn() => Inertia::render('Inicio'))
        ->name('inicio');

    Route::get('/perfil', [ProfileController::class, 'edit'])
        ->name('profile.edit');
    Route::patch('/perfil', [ProfileController::class, 'update'])
        ->name('profile.update');
});

require __DIR__ . '/auth.php';
