function hideCart() {
    $('#cart-modal').modal('hide');
}
function showCart() {
    $('#cart-modal').modal('show');
}

function updateCart(html, count) {
    $('#cart-modal-content').html(html);
    $('#cart-items-count').html(count)
}

function updateAndShowCart(html, count) {
    updateCart(html, count);
    showCart();
}