package com.model;

import java.sql.Timestamp;

public class InvoiceDetailsModel {

    private int imageId;

    private String vendorName;
    private String invoiceNumber;
    private String invoiceDate;
    private String poNumber;
    private double invoiceTotal;

    private String itemNo;
    private String itemName;
    private String price;
    private String quantity;
    private String cgst;
    private String sgst;
    private String itemTotal;
    private double subTotal;

    private String verifiedBy;
    private Timestamp verifiedTime;

    // ===== getters & setters =====
    public int getImageId() { return imageId; }
    public void setImageId(int imageId) { this.imageId = imageId; }

    public String getVendorName() { return vendorName; }
    public void setVendorName(String vendorName) { this.vendorName = vendorName; }

    public String getInvoiceNumber() { return invoiceNumber; }
    public void setInvoiceNumber(String invoiceNumber) { this.invoiceNumber = invoiceNumber; }

    public String getInvoiceDate() { return invoiceDate; }
    public void setInvoiceDate(String invoiceDate) { this.invoiceDate = invoiceDate; }

    public String getPoNumber() { return poNumber; }
    public void setPoNumber(String poNumber) { this.poNumber = poNumber; }

    public double getInvoiceTotal() { return invoiceTotal; }
    public void setInvoiceTotal(double invoiceTotal) { this.invoiceTotal = invoiceTotal; }

    public String getItemNo() { return itemNo; }
    public void setItemNo(String itemNo) { this.itemNo = itemNo; }

    public String getItemName() { return itemName; }
    public void setItemName(String itemName) { this.itemName = itemName; }

    public String getPrice() { return price; }
    public void setPrice(String price) { this.price = price; }

    public String getQuantity() { return quantity; }
    public void setQuantity(String quantity) { this.quantity = quantity; }

    public String getCgst() { return cgst; }
    public void setCgst(String cgst) { this.cgst = cgst; }

    public String getSgst() { return sgst; }
    public void setSgst(String sgst) { this.sgst = sgst; }

    public String getItemTotal() { return itemTotal; }
    public void setItemTotal(String itemTotal) { this.itemTotal = itemTotal; }

    public double getSubTotal() { return subTotal; }
    public void setSubTotal(double subTotal) { this.subTotal = subTotal; }

    public String getVerifiedBy() { return verifiedBy; }
    public void setVerifiedBy(String verifiedBy) { this.verifiedBy = verifiedBy; }

    public Timestamp getVerifiedTime() { return verifiedTime; }
    public void setVerifiedTime(Timestamp verifiedTime) { this.verifiedTime = verifiedTime; }
}
