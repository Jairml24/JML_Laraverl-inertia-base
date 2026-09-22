<script setup>
    const appName = import.meta.env.VITE_APP_NAME || 'Sistema'
</script>

<template>
    <div
        class="relative overflow-hidden text-white md:w-1/2 flex flex-col justify-between px-10 py-12 md:px-16 md:py-16 border-r-[3px] border-r-[#B8935A]"
        style="background: radial-gradient(circle at 30% 40%, #1B3A6B 0%, #0B1B33 70%);"
    >
        <svg class="absolute inset-0 w-full h-full opacity-40 pointer-events-none" xmlns="http://www.w3.org/2000/svg">
            <g stroke="#7FB2E5" stroke-opacity="0.25" stroke-width="1">
                <line x1="8%" y1="15%" x2="22%" y2="30%" />
                <line x1="22%" y1="30%" x2="15%" y2="55%" />
                <line x1="22%" y1="30%" x2="40%" y2="20%" />
                <line x1="40%" y1="20%" x2="55%" y2="35%" />
                <line x1="15%" y1="55%" x2="35%" y2="65%" />
                <line x1="35%" y1="65%" x2="55%" y2="35%" />
                <line x1="35%" y1="65%" x2="25%" y2="85%" />
                <line x1="55%" y1="35%" x2="70%" y2="50%" />
                <line x1="70%" y1="50%" x2="60%" y2="75%" />
                <line x1="25%" y1="85%" x2="60%" y2="75%" />
                <line x1="8%" y1="15%" x2="5%" y2="45%" />
            </g>
            <g fill="#A9D0F5">
                <circle cx="8%" cy="15%" r="2.5" />
                <circle cx="22%" cy="30%" r="3" />
                <circle cx="40%" cy="20%" r="2" />
                <circle cx="15%" cy="55%" r="2" />
                <circle cx="55%" cy="35%" r="3.5" />
                <circle cx="35%" cy="65%" r="2.5" />
                <circle cx="70%" cy="50%" r="2" />
                <circle cx="25%" cy="85%" r="2" />
                <circle cx="60%" cy="75%" r="2.5" />
                <circle cx="5%" cy="45%" r="1.5" />
            </g>
        </svg>

        <div class="relative"></div>

        <div class="relative flex items-center gap-5">
            <img src="/images/logo.png" alt="" class="h-20 w-20 shrink-0" @error="$event.target.style.display='none'" />
            <div>
                <h1 class="text-4xl md:text-5xl font-semibold leading-tight tracking-tight mb-3">
                    {{ appName }}
                </h1>

            </div>
        </div>

        <p class="relative text-xs text-blue-100/40">
            © {{ new Date().getFullYear() }} {{ appName }}
        </p>
    </div>
</template>