// resources/js/plugins/validation.js
import { defineRule, configure } from "vee-validate";
import {
    required,
    email,
    min,
    max,
    numeric,
    confirmed,
} from "@vee-validate/rules";
import { localize, setLocale } from "@vee-validate/i18n";

defineRule("required", required);
defineRule("email", email);
defineRule("min", min);
defineRule("max", max);
defineRule("numeric", numeric);
defineRule("confirmed", confirmed);

configure({
    generateMessage: localize("es", {
        messages: {
            required: "El campo {field} es obligatorio",
            email: "Correo inválido",
            min: "El campo {field} debe tener al menos 0:{length} caracteres",
            max: "El campo {field} no debe superar los 0:{length} caracteres",
            numeric: "Solo se permiten números",
            confirmed: "No coincide con el campo anterior",
        },
    }),
});

setLocale("es");
