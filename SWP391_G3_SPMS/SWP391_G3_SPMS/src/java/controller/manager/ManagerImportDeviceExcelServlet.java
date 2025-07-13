package controller.manager;

import dao.manager.DeviceDao;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;  // Cho phép nhận file upload
import jakarta.servlet.http.*;
import model.customer.User;
import model.manager.Device;
import org.apache.poi.ss.usermodel.*;   // Đọc dữ liệu từ Excel
import org.apache.poi.xssf.usermodel.XSSFWorkbook;  // Xử lý file Excel định dạng .xlsx

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 20 // 20MB
)
@WebServlet(name = "ManagerImportDeviceExcelServlet", urlPatterns = {"/ManagerImportDeviceExcelServlet"})
public class ManagerImportDeviceExcelServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        int branchId = 0;
        if (currentUser != null) {
            int currentUser_id = currentUser.getUser_id();
            switch (currentUser_id) {
                case 2:
                    branchId = 1; // hà nội
                    break;
                case 3:
                    branchId = 2; // hồ chí minh
                    break;
                case 4:
                    branchId = 3; // đà nẵng
                    break;
                case 5:
                    branchId = 4; // quy nhơn
                    break;
                case 6:
                    branchId = 5; // cần thơ
                    break;
                default:
                    throw new AssertionError();
            }
        }
        DeviceDao dao = new DeviceDao();

        Part excelFile = request.getPart("excelFile");   // Lấy file đã upload:
        List<String> errorList = new ArrayList<>();
        int imported = 0;

        if (excelFile != null && excelFile.getSize() > 0) {
            try (InputStream inputStream = excelFile.getInputStream(); Workbook workbook = new XSSFWorkbook(inputStream)) {  // inputStream = excelFile.getInputStream() mở luồng đọc file.
                Sheet sheet = workbook.getSheetAt(0);  // Lấy sheet đầu tiên                                                                 // XSSFWorkbook là class của Apache POI để đọc file .xlsx
                int rowNum = 0;
                for (Row row : sheet) {
                    if (rowNum++ == 0) {  // bỏ qua dòng tiêu đề
                        continue; // bỏ header
                    }
                    try {
                        String deviceName = getCellString(row.getCell(0));
                        int quantity = (int) row.getCell(1).getNumericCellValue();
                        String status = getCellString(row.getCell(2));
                        String notes = getCellString(row.getCell(3));
                        int poolId = (int) row.getCell(4).getNumericCellValue();

                        // Validate
                        if (deviceName == null || deviceName.isEmpty() || !deviceName.matches("[a-zA-Z0-9\\sÀ-ỹ]+")) {
                            errorList.add("Dòng " + (rowNum) + ": Tên thiết bị không hợp lệ.");
                            continue;
                        }
                        if (quantity < 1) {
                            errorList.add("Dòng " + (rowNum) + ": Số lượng phải >= 1.");
                            continue;
                        }
                        if (!status.equals("available") && !status.equals("maintenance") && !status.equals("broken")) {
                            errorList.add("Dòng " + (rowNum) + ": Trạng thái phải là 'available', 'maintenance', hoặc 'broken'.");
                            continue;
                        }
                        if (dao.isDeviceNameExistsInPool(poolId, deviceName)) {
                            errorList.add("Dòng " + (rowNum) + ": Tên thiết bị đã tồn tại trong hồ bơi.");
                            continue;
                        }

                        Device device = new Device(0, null, deviceName, poolId, null, quantity, status, notes);
                        dao.addDevice(device);
                        imported++;
                    } catch (Exception ex) {
                        errorList.add("Dòng " + (rowNum) + ": Lỗi dữ liệu.");
                    }
                }
            } catch (Exception e) {
                errorList.add("Không thể đọc file Excel. Đảm bảo đúng định dạng.");
            }
        } else {
            errorList.add("Không có file được chọn.");
        }

        request.setAttribute("imported", imported);
        request.setAttribute("errorList", errorList);

        String poolId = request.getParameter("poolId");
        String keyword = request.getParameter("keyword");
        String status = request.getParameter("status");
        String pageSizeParam = request.getParameter("pageSize");
        int pageSize = (pageSizeParam != null) ? Integer.parseInt(pageSizeParam) : 5;
        Integer filterPoolId = (poolId != null && !poolId.isEmpty()) ? Integer.parseInt(poolId) : null;

        int count = dao.countDevicesWithPool(keyword, status, branchId, filterPoolId);
        int endPage = count / pageSize;
        if (count % pageSize != 0) {
            endPage++;
        }
        String redirectUrl = "managerListDeviceServlet?page=" + endPage;
        if (poolId != null) {
            redirectUrl += "&poolId=" + poolId;
        }
        if (keyword != null) {
            redirectUrl += "&keyword=" + java.net.URLEncoder.encode(keyword, "UTF-8");
        }
        if (status != null) {
            redirectUrl += "&status=" + status;
        }
        redirectUrl += "&pageSize=" + pageSize;

        if (!errorList.isEmpty()) {
            if (imported == 0) {
                errorList.add(0, "Không có thiết bị nào được thêm!");
            }
            session.setAttribute("importErrors", errorList);
        }

        if (imported > 0) {
            session.setAttribute("importSuccess", "Nhập thiết bị thành công! Đã thêm: " + imported + " thiết bị.");
        }

        response.sendRedirect(redirectUrl);

    }

    private String getCellString(Cell cell) {  // Hàm này ép kiểu ô về chuỗi 
        if (cell == null) {
            return "";
        }
        cell.setCellType(CellType.STRING);
        return cell.getStringCellValue().trim();
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
