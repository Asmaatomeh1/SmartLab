import 'package:appwithfirebase/auth.dart';
import 'package:flutter/material.dart';

Widget customAppBar() {
  return SafeArea(
    child: Container(
      padding: const EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 10,
        //     offset: Offset(0, 5),
        //   ),
        // ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// الصف الأول (الاسم + الأيقونات)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Hi ${AppAuth.currentUser?.fullName.fullNameText}!",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(Icons.keyboard_arrow_down),
                ],
              ),
              const Row(
                children: [
                  Icon(Icons.notifications_none),
                  SizedBox(width: 12),
                  Icon(Icons.shopping_cart_outlined),
                ],
              ),
            ],
          ),

          const SizedBox(height: 5),

          /// الموقع
          const Row(
            children: [
              Icon(Icons.location_on, size: 16, color: Colors.orange),
              SizedBox(width: 5),
              Text("Tulkarm, Palestine", style: TextStyle(color: Colors.grey)),
            ],
          ),

          const SizedBox(height: 15),

          /// Search Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: "Search for tests and packages",
                border: InputBorder.none,
                icon: Icon(Icons.search),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
