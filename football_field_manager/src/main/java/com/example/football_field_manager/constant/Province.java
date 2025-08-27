package com.example.football_field_manager.constant;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonValue;

public enum Province {
    AN_GIANG("An Giang"),
    BA_RIA_VUNG_TAU("Bà Rịa - Vũng Tàu"),
    BAC_GIANG("Bắc Giang"),
    BAC_KAN("Bắc Kạn"),
    BAC_LIEU("Bạc Liêu"),
    BAC_NINH("Bắc Ninh"),
    BEN_TRE("Bến Tre"),
    BINH_DINH("Bình Định"),
    BINH_DUONG("Bình Dương"),
    BINH_PHUOC("Bình Phước"),
    BINH_THUAN("Bình Thuận"),
    CA_MAU("Cà Mau"),
    CAN_THO("Cần Thơ"),
    CAO_BANG("Cao Bằng"),
    DANANG("Đà Nẵng"),
    DAK_LAK("Đắk Lắk"),
    DAK_NONG("Đắk Nông"),
    DIEN_BIEN("Điện Biên"),
    DONG_NAI("Đồng Nai"),
    DONG_THAP("Đồng Tháp"),
    GIA_LAI("Gia Lai"),
    HANOI("Hà Nội"),
    HCMC("TP Hồ Chí Minh"),
    HAIPHONG("Hải Phòng"),
    HA_GIANG("Hà Giang"),
    HA_NAM("Hà Nam"),
    HA_TINH("Hà Tĩnh"),
    HAI_DUONG("Hải Dương"),
    HAU_GIANG("Hậu Giang"),
    HOA_BINH("Hòa Bình"),
    HUNG_YEN("Hưng Yên"),
    KHANH_HOA("Khánh Hòa"),
    KIEN_GIANG("Kiên Giang"),
    KON_TUM("Kon Tum"),
    LAI_CHAU("Lai Châu"),
    LAM_DONG("Lâm Đồng"),
    LANG_SON("Lạng Sơn"),
    LAO_CAI("Lào Cai"),
    LONG_AN("Long An"),
    NAM_DINH("Nam Định"),
    NGHE_AN("Nghệ An"),
    NINH_BINH("Ninh Bình"),
    NINH_THUAN("Ninh Thuận"),
    PHU_THO("Phú Thọ"),
    PHU_YEN("Phú Yên"),
    QUANG_BINH("Quảng Bình"),
    QUANG_NAM("Quảng Nam"),
    QUANG_NGAI("Quảng Ngãi"),
    QUANG_NINH("Quảng Ninh"),
    QUANG_TRI("Quảng Trị"),
    SOC_TRANG("Sóc Trăng"),
    SON_LA("Sơn La"),
    TAY_NINH("Tây Ninh"),
    THAI_BINH("Thái Bình"),
    THAI_NGUYEN("Thái Nguyên"),
    THANH_HOA("Thanh Hóa"),
    THUA_THIEN_HUE("Thừa Thiên Huế"),
    TIEN_GIANG("Tiền Giang"),
    TRA_VINH("Trà Vinh"),
    TUYEN_QUANG("Tuyên Quang"),
    VINH_LONG("Vĩnh Long"),
    VINH_PHUC("Vĩnh Phúc"),
    YEN_BAI("Yên Bái");

    private final String displayName;

    Province(String displayName) {
        this.displayName = displayName;
    }

    @JsonValue
    public String getDisplayName() {
        return displayName;
    }

    @JsonCreator
    public static Province fromValue(String value) {
        for (Province p : values()) {
            if (p.displayName.equalsIgnoreCase(value)) {
                return p;
            }
        }
        throw new IllegalArgumentException("Tỉnh/Thành không hợp lệ: " + value);
    }

}

