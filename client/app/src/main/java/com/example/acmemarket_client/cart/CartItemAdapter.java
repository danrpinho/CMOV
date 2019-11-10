package com.example.acmemarket_client.cart;

import android.view.LayoutInflater;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.example.acmemarket_client.R;

import java.util.ArrayList;
import java.util.Locale;

public class CartItemAdapter extends RecyclerView.Adapter<CartItemViewHolder> {
    private final ArrayList<Product> items;

    public CartItemAdapter(ArrayList data){
        this.items = data;
    }

    @NonNull
    @Override
    public CartItemViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        return new CartItemViewHolder(LayoutInflater.from(parent.getContext())
                .inflate(R.layout.recycle_cart_item, parent, false));
    }

    @Override
    public void onBindViewHolder(@NonNull CartItemViewHolder holder, int position) {
        holder.itemName.setText(String.format(Locale.getDefault(), "%s \n %.2f",
                items.get(position).getName(), items.get(position).getPrice()));

        holder.deleteButton.setOnClickListener(view -> removeItem(position));
    }

    //adds an item to the list
    public void addItem(Product item){
        items.add(item);
        notifyItemInserted(getItemCount());
    }

    //removes an item from the list
    private void removeItem(int position) {
        items.remove(position);
        notifyItemRemoved(position);
        notifyItemRangeChanged(position, items.size());
    }

    @Override
    public int getItemCount() {
        if (items == null)
            return 0;
        else return items.size();
    }
}
