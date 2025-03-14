class APIConst {
  static const baseUrl = 'https://mongrel-infinite-stallion.ngrok-free.app/api';

  //product
  static const allProducts = '$baseUrl/products';
  static const oneProduct = '$baseUrl/products/:id';
  static const productbycategory = '$baseUrl/products/category/:category';
  static const sortedProduct = '$baseUrl/products/sorted';

  //category
  static const allCategories = '$baseUrl/category';
  static const oneCategorie = '$baseUrl/category/:id';

  //order
  static const allOrders = '$baseUrl/orders/user/:userId';
  static const oneOrder = '$baseUrl/orders/:id';
  static const placeOrder = '$baseUrl/orders/place';
  static const updateOrderstatus = '$baseUrl/orders/update-status';

  //cart
  static const userCart = '$baseUrl/cart/:userId';
  static const removesaleCart = '$baseUrl/cart/remove';
  static const addsaleCart = '$baseUrl/cart/add';
  static const clearCart = '$baseUrl/cart/clear/:userId';
  static const createCart = '$baseUrl/cart/create';

  //sale
  static const createSale = '$baseUrl/sales/create';
  static const allSales = '$baseUrl/sales';
  static const oneSale = '$baseUrl/sales/:id';
  static const updateSale = '$baseUrl/sales/update/:id';
  static const deleteSale = '$baseUrl/sales/delete/:id';

  //supplement
  static const oneSupplement = '$baseUrl/supp';

  //wishlist
  static const createWishList = '$baseUrl/wishList/create';

  static const getWishlist = '$baseUrl/wishlist/get';
  static const updateWishlist = '$baseUrl/wishlist/update';
  static const deleteWishlist = '$baseUrl/wishlist/delete';
  static const removeproductWishlist = '$baseUrl/wishlist/remove-product';

  //user
  static const register = '$baseUrl/register';
  static const login = '$baseUrl/login';
  static const userProfile = '$baseUrl/profile';
  static const updateProfile = '$baseUrl/profile/update';
  static const updatePassword = '$baseUrl/update-password';
  static const forgetPassword = '$baseUrl/forgetPassword';
  static const resetPassword = '$baseUrl/Resetpassword';
  static const verfifCode = '$baseUrl/VerifCode';
  static const updateUserImage = '$baseUrl/updateImage';
}
