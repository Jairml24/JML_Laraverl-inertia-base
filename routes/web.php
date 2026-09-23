<?php

use App\Http\Controllers\ProfileController;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

Route::middleware('auth')->group(function () {
    Route::get('/inicio', fn() => Inertia::render('Inicio'))
        ->name('inicio');

    Route::prefix('reportes')->name('reportes.')->group(function () {
        Route::get('/emergencia', fn() => Inertia::render('Reportes/Emergencia'))
            ->name('emergencia');
        Route::get('/hospitalizacion', fn() => Inertia::render('Reportes/Hospitalizacion'))
            ->name('hospitalizacion');
    });

    Route::prefix('configuracion')->name('config.')->group(function () {
        Route::get('/usuarios', fn() => Inertia::render('Configuracion/Usuarios'))
            ->name('usuarios');
        Route::get('/roles', fn() => Inertia::render('Configuracion/Roles'))
            ->name('roles');
    });
});

require __DIR__.'/auth.php';

