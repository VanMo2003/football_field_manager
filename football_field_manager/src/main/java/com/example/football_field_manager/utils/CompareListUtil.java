package com.example.football_field_manager.utils;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class CompareListUtil {
    public static boolean compare(List<Long> serviceIdOld, List<Long> serviceIdRequest) {
        if (serviceIdOld.size() != serviceIdRequest.size()) return false;

        List<Long> sortedOld = new ArrayList<>(serviceIdOld);
        List<Long> sortedRequest = new ArrayList<>(serviceIdRequest);

        Collections.sort(sortedOld);
        Collections.sort(sortedRequest);

        return sortedOld.equals(sortedRequest);
    }
}
