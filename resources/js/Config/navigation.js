import { LayoutDashboard, BarChart3, Settings } from "lucide-vue-next";

// Un link normal: { label, route, icon }
// Un grupo con submenú: { label, icon, children: [{ label, route }, ...] }
export const navigation = [
    { label: "Inicio", route: "inicio", icon: LayoutDashboard },
    {
        label: "Reportes",
        icon: BarChart3,
        children: [
            { label: "Emergencia", route: "reportes.emergencia" },
            { label: "Hospitalización", route: "reportes.hospitalizacion" },
        ],
    },
    {
        label: "Configuración",
        icon: Settings,
        children: [
            { label: "Usuarios", route: "config.usuarios" },
            { label: "Roles", route: "config.roles" },
        ],
    },
];
