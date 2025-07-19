package model.staff;

public class StaffJoinedTable {
    private int staffId;
    private int userId;
    private int branchId;
    private String branchName;
    private int poolId;
    private String poolName;
    private int staffTypeId;
    private String typeName;
    private String typeDescription;

    public StaffJoinedTable() {
    }

    public StaffJoinedTable(int staffId, int userId, int branchId, String branchName,
                            int poolId, String poolName, int staffTypeId,
                            String typeName, String typeDescription) {
        this.staffId = staffId;
        this.userId = userId;
        this.branchId = branchId;
        this.branchName = branchName;
        this.poolId = poolId;
        this.poolName = poolName;
        this.staffTypeId = staffTypeId;
        this.typeName = typeName;
        this.typeDescription = typeDescription;
    }

    // Getters and Setters

    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getBranchId() {
        return branchId;
    }

    public void setBranchId(int branchId) {
        this.branchId = branchId;
    }

    public String getBranchName() {
        return branchName;
    }

    public void setBranchName(String branchName) {
        this.branchName = branchName;
    }

    public int getPoolId() {
        return poolId;
    }

    public void setPoolId(int poolId) {
        this.poolId = poolId;
    }

    public String getPoolName() {
        return poolName;
    }

    public void setPoolName(String poolName) {
        this.poolName = poolName;
    }

    public int getStaffTypeId() {
        return staffTypeId;
    }

    public void setStaffTypeId(int staffTypeId) {
        this.staffTypeId = staffTypeId;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public String getTypeDescription() {
        return typeDescription;
    }

    public void setTypeDescription(String typeDescription) {
        this.typeDescription = typeDescription;
    }
}
