package com.model;

public class InvoiceImageModel {
    private int imageId;
    private String imagePath;
    private String status;
    private String assignedToUser;
    private String assignedToQc;
    private String verifiedBy;
    private String qcCheckedBy;
    private String errors;

    public int getImageId() { return imageId; }
    public void setImageId(int imageId) { this.imageId = imageId; }

    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getAssignedToUser() { return assignedToUser; }
    public void setAssignedToUser(String assignedToUser) { this.assignedToUser = assignedToUser; }

    public String getAssignedToQc() { return assignedToQc; }
    public void setAssignedToQc(String assignedToQc) { this.assignedToQc = assignedToQc; }

    public String getVerifiedBy() { return verifiedBy; }
    public void setVerifiedBy(String verifiedBy) { this.verifiedBy = verifiedBy; }

    public String getQcCheckedBy() { return qcCheckedBy; }
    public void setQcCheckedBy(String qcCheckedBy) { this.qcCheckedBy = qcCheckedBy; }

    public String getErrors() { return errors; }
    public void setErrors(String errors) { this.errors = errors; }
}







//package com.model;
//
//public class InvoiceImageModel {
//    private int imageId;
//    private String imagePath;
//    private String status;
//    private String assignedToUser;
//    private String assignedToQc;
//    private String verifiedBy;
//    private String qcCheckedBy;
//    private String errors;
//    
//    // Getters and setters for all fields
//    public int getImageId() { return imageId; }
//    public void setImageId(int imageId) { this.imageId = imageId; }
//    
//    public String getImagePath() { return imagePath; }
//    public void setImagePath(String imagePath) { this.imagePath = imagePath; }
//    
//    public String getStatus() { return status; }
//    public void setStatus(String status) { this.status = status; }
//    
//    public String getAssignedToUser() { return assignedToUser; }
//    public void setAssignedToUser(String assignedToUser) { this.assignedToUser = assignedToUser; }
//    
//    public String getAssignedToQc() { return assignedToQc; }
//    public void setAssignedToQc(String assignedToQc) { this.assignedToQc = assignedToQc; }
//    
//    public String getVerifiedBy() { return verifiedBy; }
//    public void setVerifiedBy(String verifiedBy) { this.verifiedBy = verifiedBy; }
//    
//    public String getQcCheckedBy() { return qcCheckedBy; }
//    public void setQcCheckedBy(String qcCheckedBy) { this.qcCheckedBy = qcCheckedBy; }
//    
//    public String getErrors() { return errors; }
//    public void setErrors(String errors) { this.errors = errors; }
//}