<script>
document.addEventListener("DOMContentLoaded", function () {

    const titles = document.querySelectorAll(".menu-title");

    titles.forEach(title => {
        title.addEventListener("click", function () {

            const parent = this.parentElement;

            document.querySelectorAll(".menu-group").forEach(group => {
                if (group !== parent) {
                    group.classList.remove("active");
                }
            });

            parent.classList.toggle("active");
        });
    });

});
</script>