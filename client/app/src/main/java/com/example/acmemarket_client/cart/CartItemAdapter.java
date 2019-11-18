package com.example.acmemarket_client.cart;

import android.view.LayoutInflater;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.example.acmemarket_client.R;
import com.example.acmemarket_client.model.Product;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

public class CartItemAdapter extends RecyclerView.Adapter<CartItemViewHolder> {

    private ArrayList<Object> items;
    private CartView view;

    public CartItemAdapter(ArrayList data, CartView view){
        this.items = data;
        this.view = view;
    }

    /**
     * Activity that states what to do when creating the ViewHolder.
     * @param parent The parent activity, required to inflate the layout.
     * @param viewType
     * @return
     */
    @NonNull
    @Override
    public CartItemViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        return new CartItemViewHolder(LayoutInflater.from(parent.getContext())
                .inflate(R.layout.recycle_cart_item, parent, false));
    }

    /**
     * Connects the cart item list to the ViewHolder and activates the buttons
     * @param holder The Activity ViewHolder
     * @param position The position of the item list related to the item in question
     */
    @Override
    public void onBindViewHolder(@NonNull CartItemViewHolder holder, int position) {
        Product current = (Product) items.get(position);
        holder.itemName.setText(String.format(Locale.getDefault(), "%s \n %.2f",
                current.getName(), current.getPrice()));

        holder.deleteButton.setOnClickListener(view -> removeItem(position));
    }


    //TODO switches dos vouchers e do saldo

    /**
     * Adds an item to the list.
      * @param item The Product to be added to the cart list.
     */
    public void addItem(Product item){
        items.add(item);
        notifyItemInserted(getItemCount());
    }

    /**
     * Removes an item from the list.
     * @param position The position from which the item was removed.
     */
    private void removeItem(int position) {
        items.remove(position);
        notifyItemRemoved(position);
        notifyItemRangeChanged(position, items.size());
        view.saveCart(items);
    }

    /**
     * Gets the amount of items in the cart
     * @return The amount of items in the cart
     */
    @Override
    public int getItemCount() {
        if (items == null)
            return 0;
        else return items.size();
    }

    public void addList(ArrayList<Object> cart) {
        int start = items.size();
        items.addAll(cart);
        notifyItemRangeChanged(start, cart.size());
    }

    public List<Object> getItems() {
        return items;
    }

}
