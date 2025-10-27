import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mandir/screen/support/controller.dart';
import 'package:mandir/utils/helper.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SupportController());
    SizeConfig.initWithContext(context);

    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: ThemeColors.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ThemeColors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Support & Help',
          style: TextStyle(
            color: ThemeColors.white,
            fontSize: 4.w,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return _buildLoadingWidget();
        }

        if (controller.errorMessage.value.isNotEmpty &&
            controller.supportContacts.isEmpty) {
          return _buildErrorWidget(controller);
        }

        if (controller.supportContacts.isEmpty) {
          return _buildEmptyWidget();
        }

        return RefreshIndicator(
          onRefresh: controller.refreshData,
          color: ThemeColors.primaryColor,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                // Header Section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(5.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        ThemeColors.primaryColor,
                        ThemeColors.primaryColor.withOpacity(0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(6.w),
                      bottomRight: Radius.circular(6.w),
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.support_agent,
                        size: 15.w,
                        color: ThemeColors.white,
                      ),
                      2.h.vs,
                      Text(
                        'We\'re Here to Help',
                        style: TextStyle(
                          fontSize: 4.5.w,
                          fontWeight: FontWeight.bold,
                          color: ThemeColors.white,
                        ),
                      ),
                      1.h.vs,
                      Text(
                        'Contact our support team',
                        style: TextStyle(
                          fontSize: 3.w,
                          color: ThemeColors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),

                3.h.vs,

                // Support Contacts List
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  itemCount: controller.supportContacts.length,
                  itemBuilder: (context, index) {
                    final contact = controller.supportContacts[index];
                    return _buildSupportCard(contact, controller);
                  },
                ),

                2.h.vs,

                // FAQ Section
                _buildFAQSection(),

                3.h.vs,
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: ThemeColors.primaryColor),
          2.h.vs,
          Text(
            'Loading support contacts...',
            style: TextStyle(fontSize: 3.5.w, color: ThemeColors.greyColor),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(SupportController controller) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(5.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 20.w,
              color: Colors.red.withOpacity(0.5),
            ),
            2.h.vs,
            Text(
              'Oops!',
              style: TextStyle(
                fontSize: 5.w,
                fontWeight: FontWeight.bold,
                color: ThemeColors.defaultTextColor,
              ),
            ),
            1.h.vs,
            Text(
              controller.errorMessage.value,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 3.5.w, color: ThemeColors.greyColor),
            ),
            3.h.vs,
            ElevatedButton.icon(
              onPressed: controller.refreshData,
              icon: Icon(Icons.refresh),
              label: Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeColors.primaryColor,
                foregroundColor: ThemeColors.white,
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.w),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.contact_support_outlined,
            size: 20.w,
            color: ThemeColors.greyColor.withOpacity(0.5),
          ),
          2.h.vs,
          Text(
            'No Support Contacts',
            style: TextStyle(
              fontSize: 4.w,
              fontWeight: FontWeight.w600,
              color: ThemeColors.defaultTextColor,
            ),
          ),
          1.h.vs,
          Text(
            'Support contacts will appear here',
            style: TextStyle(fontSize: 3.w, color: ThemeColors.greyColor),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportCard(
    SupportContact contact,
    SupportController controller,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 3.h),
      decoration: BoxDecoration(
        color: ThemeColors.white,
        borderRadius: BorderRadius.circular(3.w),
        boxShadow: [
          BoxShadow(
            color: ThemeColors.greyColor.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with Avatar
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ThemeColors.primaryColor.withOpacity(0.1),
                  ThemeColors.primaryColor.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(3.w)),
            ),
            child: Row(
              children: [
                Container(
                  width: 15.w,
                  height: 15.w,
                  decoration: BoxDecoration(
                    color: ThemeColors.primaryColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: ThemeColors.primaryColor.withOpacity(0.3),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      contact.name.isNotEmpty
                          ? contact.name[0].toUpperCase()
                          : 'S',
                      style: TextStyle(
                        fontSize: 6.w,
                        fontWeight: FontWeight.bold,
                        color: ThemeColors.white,
                      ),
                    ),
                  ),
                ),
                3.w.hs,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contact.name,
                        style: TextStyle(
                          fontSize: 4.w,
                          fontWeight: FontWeight.bold,
                          color: ThemeColors.defaultTextColor,
                        ),
                      ),
                      0.5.h.vs,
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 2.w,
                          vertical: 0.5.h,
                        ),
                        decoration: BoxDecoration(
                          color: ThemeColors.primaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(1.w),
                        ),
                        child: Text(
                          'Support Team',
                          style: TextStyle(
                            fontSize: 2.5.w,
                            color: ThemeColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              children: [
                // Phone Number
                _buildContactRow(
                  icon: Icons.phone,
                  label: 'Phone',
                  value: contact.phoneNumber,
                  onTap: () => controller.makePhoneCall(contact.phoneNumber),
                  onCopy: () {
                    Clipboard.setData(ClipboardData(text: contact.phoneNumber));
                    controller.copyToClipboard(
                      contact.phoneNumber,
                      'Phone number',
                    );
                  },
                ),

                Divider(height: 3.h),

                // Email
                _buildContactRow(
                  icon: Icons.email,
                  label: 'Email',
                  value: contact.email,
                  onTap: () => controller.sendEmail(contact.email),
                  onCopy: () {
                    Clipboard.setData(ClipboardData(text: contact.email));
                    controller.copyToClipboard(contact.email, 'Email');
                  },
                ),

                2.h.vs,

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: _buildActionButton(
                        icon: Icons.phone,
                        label: 'Call',
                        color: Colors.green,
                        onTap:
                            () => controller.makePhoneCall(contact.phoneNumber),
                      ),
                    ),
                    2.w.hs,
                    Expanded(
                      child: _buildActionButton(
                        icon: Icons.chat,
                        label: 'WhatsApp',
                        color: Color(0xFF25D366),
                        onTap:
                            () => controller.sendWhatsApp(contact.phoneNumber),
                      ),
                    ),
                    2.w.hs,
                    Expanded(
                      child: _buildActionButton(
                        icon: Icons.email,
                        label: 'Email',
                        color: Colors.blue,
                        onTap: () => controller.sendEmail(contact.email),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
    required VoidCallback onCopy,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            color: ThemeColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(2.w),
          ),
          child: Icon(icon, color: ThemeColors.primaryColor, size: 5.w),
        ),
        3.w.hs,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 2.5.w, color: ThemeColors.greyColor),
              ),
              0.5.h.vs,
              Text(
                value,
                style: TextStyle(
                  fontSize: 3.5.w,
                  fontWeight: FontWeight.w500,
                  color: ThemeColors.defaultTextColor,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onCopy,
          icon: Icon(Icons.copy, color: ThemeColors.greyColor, size: 4.w),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1.5.h),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(2.w),
          border: Border.all(color: color.withOpacity(0.3), width: 1),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 5.w),
            0.5.h.vs,
            Text(
              label,
              style: TextStyle(
                fontSize: 2.8.w,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: ThemeColors.oldLatterLight4,
        borderRadius: BorderRadius.circular(3.w),
        border: Border.all(
          color: ThemeColors.oldLatterLight3.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.help_outline, color: ThemeColors.oldLatter, size: 5.w),
              2.w.hs,
              Text(
                'Need Quick Help?',
                style: TextStyle(
                  fontSize: 4.w,
                  fontWeight: FontWeight.bold,
                  color: ThemeColors.oldLatter,
                ),
              ),
            ],
          ),
          2.h.vs,
          Text(
            'Our support team is available to assist you with any questions or concerns. Feel free to reach out via phone, email, or WhatsApp.',
            style: TextStyle(
              fontSize: 3.w,
              color: ThemeColors.oldLatterLight,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
