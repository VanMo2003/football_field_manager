import 'package:flutter/material.dart';
import 'package:football_field_manager_demo/utils/dimension_utils.dart';

class BookingDialog extends StatelessWidget {
  final String tenSan;
  final String diaChi;
  final String ngayDat;
  final String soDienThoai;
  final String khungGio;
  final int soSan;
  final double tongGia;
  final VoidCallback onConfirm;

  const BookingDialog({
    super.key,
    required this.tenSan,
    required this.diaChi,
    required this.ngayDat,
    required this.soDienThoai,
    required this.khungGio,
    required this.soSan,
    required this.tongGia,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Xác nhận đặt sân",
                style: TextStyle(
                  fontSize: DimensionUtils.FONT_SIZE_OVER_LARGE,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildRow("Tên sân:", tenSan),
            _buildRow("Địa chỉ:", diaChi),
            _buildRow("Ngày đặt:", ngayDat),
            _buildRow("SĐT:", soDienThoai),
            _buildRow("Khung giờ:", khungGio),
            _buildRow("Số sân:", "$soSan"),
            _buildRow("Tổng giá:", "${tongGia.toStringAsFixed(0)} VND"),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: onConfirm,
                child: Text(
                  "Xác nhận đặt sân",
                  style: TextStyle(fontSize: DimensionUtils.FONT_SIZE_DEFAULT, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              maxLines: 2,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: DimensionUtils.FONT_SIZE_LARGE),
            ),
          ),
          Expanded(flex: 5, child: Text(value, maxLines: 2,style: TextStyle(fontSize: DimensionUtils.FONT_SIZE_LARGE),)),
        ],
      ),
    );
  }
}
