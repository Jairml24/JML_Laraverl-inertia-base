// resources/js/Composables/useClickOutside.js
import { onMounted, onUnmounted } from "vue";
export function useClickOutside(elementRef, callback) {
    function handleClick(event) {
        if (elementRef.value && !elementRef.value.contains(event.target)) {
            callback(event);
        }
    }

    onMounted(() => document.addEventListener("click", handleClick));
    onUnmounted(() => document.removeEventListener("click", handleClick));
}
