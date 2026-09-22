<?php

use App\Http\Controllers\ProfileController;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

Route::middleware('auth')->group(function () {
    Route::get('/inicio', function () {
        return Inertia::render('Inicio');
    })->name('inicio');
});


require __DIR__.'/auth.php';

