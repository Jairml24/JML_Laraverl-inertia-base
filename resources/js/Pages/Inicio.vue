<script setup>
import { useForm } from "@inertiajs/vue3";
import AppLayout from "@/Layouts/AppLayout.vue";
import VButton from "@/Components/VButton.vue";
import VInput from "@/Components/VInput.vue";

const form = useForm({
    nombre: "",
    apellidos: "",
});
</script>

<template>
    <AppLayout title="Inicio">
        <div class="flex gap-5">
            <VInput
                label="Nombres"
                name="nombres"
                rules="required|min:4"
                v-model="form.nombre"
            />
            <VInput
                label="Apellidos"
                name="apellidos"
                rules="required"
                v-model="form.apellidos"
            />
        </div>
        <VButton @click="() => form.reset()">Limpiar</VButton>
    </AppLayout>
</template>
