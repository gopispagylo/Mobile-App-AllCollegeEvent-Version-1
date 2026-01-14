import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class PrivacyPolicyModel extends StatefulWidget {
  const PrivacyPolicyModel({super.key});

  @override
  State<PrivacyPolicyModel> createState() => _PrivacyPolicyModelState();
}

class _PrivacyPolicyModelState extends State<PrivacyPolicyModel> {

  // Sample JSON converted to Map<String, dynamic>
  Map<String, dynamic> privacyPolicyJson = {
    "privacyPolicy": {
      "title": "All College Event (ACE)",
      "company": "ECLearnix EdTech Private Limited",
      "intro": "All College Event (ACE), a product of ECLearnix EdTech Private Limited, values your trust and is committed to protecting your privacy. This Privacy Policy explains how we collect, use, store, share, and safeguard your information when you access or use our website and mobile application. By using ACE, you agree to the practices described in this Privacy Policy. If you do not agree, please discontinue use of the platform.",
      "sections": [
        {
          "sectionTitle": "1. Information We Collect",
          "subsections": [
            {
              "title": "Personal Information",
              "content": "When you create an account, register for an event, or organize an event on ACE, we may collect personal information including but not limited to:",
              "points": [
                "Full name",
                "Email address",
                "Phone number",
                "Institution, Organization, or Company details",
                "Profile information provided by you",
                "Event registration and participation details"
              ],
              "note": "This information is necessary to enable account creation, event discovery, registration, participation, communication, and collaboration between organizers and participants."
            },
            {
              "title": "Organizer Information",
              "content": "If you create or collaborate on events as an organizer, we may collect additional details such as organizer name, organization details, event-related content, and collaboration or co-hosting information."
            },
            {
              "title": "Payment Information",
              "content": "For paid events, payments are processed securely through third-party payment gateways. ACE does not store or process sensitive financial information such as credit/debit card numbers, CVV details, or banking credentials. We are not responsible for any refunds, chargebacks, or payment-related disputes, including fraudulent transactions, as all payments are processed through third-party platforms."
            },
            {
              "title": "Usage and Technical Data",
              "content": "We automatically collect certain technical and usage information when you access or use our platform. This may include:",
              "points": [
                "IP address",
                "Device type and browser details",
                "Operating system",
                "Pages visited, features accessed, and interaction data",
                "Date, time, and referral source information"
              ],
              "note": "This information is collected to analyze usage patterns, improve platform functionality, enhance user experience, and maintain system security."
            }
          ]
        },
        {
          "sectionTitle": "2. How We Use Your Information",
          "subsections": [
            {
              "title": "Platform Access and Event Services",
              "content": "We use your information to:",
              "points": [
                "Create, maintain, and manage user accounts",
                "Enable event listing, discovery, registration, ticketing, and participation",
                "Support organizer collaborations and co-hosted events",
                "Send confirmations, reminders, updates, and other service-related communications"
              ]
            },
            {
              "title": "Sharing with Event Organizers",
              "content": "To facilitate event execution and coordination, ACE may share relevant participant information (such as name, email address, phone number, and registration details) with the respective event organizers or collaborating organizers. Event organizers are responsible for using such information solely for legitimate, event-related purposes and in compliance with applicable data protection laws."
            },
            {
              "title": "Platform Improvement, Analytics, and Security",
              "content": "We may use information to:",
              "points": [
                "Analyze usage patterns and platform performance",
                "Improve features, personalization, and future offerings",
                "Detect, prevent, and address fraud, misuse, and unauthorized access"
              ]
            },
            {
              "title": "Monetization and Communication",
              "content": "ACE may use limited information to:",
              "points": [
                "Communicate platform updates, feature releases, or service announcements",
                "Support present or future monetization features, including premium listings, promotions, or subscription-based services (where applicable)"
              ]
            }
          ]
        },
        {
          "sectionTitle": "3. Data Storage, Retention, and Security",
          "subsections": [
            {
              "title": "Data Security Measures",
              "content": "We implement reasonable administrative, technical, and organizational safeguards designed to protect personal data against unauthorized access, alteration, disclosure, or destruction. However, no method of transmission over the internet or electronic storage is completely secure, and absolute security cannot be guaranteed."
            },
            {
              "title": "Third-Party Services",
              "content": "ACE may engage trusted third-party service providers to support platform operations, including but not limited to payment processing, analytics, email communications, and hosting services. These third parties operate under their own privacy policies and are granted access only to the information necessary to perform their designated functions."
            },
            {
              "title": "Data Retention",
              "content": "Personal data is retained only for as long as necessary to:",
              "points": [
                "Provide and maintain platform services",
                "Comply with applicable legal and regulatory requirements",
                "Resolve disputes and enforce agreements"
              ],
              "note": "Event-related and transactional records may be retained for audit, compliance, or legal purposes. Inactive user accounts may be archived, anonymized, or deleted after a reasonable period, in accordance with applicable laws and internal policies."
            }
          ]
        },
        {
          "sectionTitle": "4. User Rights and Choices",
          "subsections": [
            {
              "title": "Access and Update",
              "content": "You may access, review, and update your personal information at any time through your ACE account dashboard, subject to applicable platform functionality."
            },
            {
              "title": "Data Requests",
              "content": "Certain information, including transaction records or event participation data, may be retained as required to comply with legal, regulatory, or operational obligations. Organizer-related content, event listings, or materials associated with published events may remain visible where retention is necessary for record-keeping or contractual purposes, unless removal is legally mandated."
            }
          ]
        },
        {
          "sectionTitle": "5. Sharing and Disclosure of Information",
          "subsections": [
            {
              "title": "Limited Data Sharing",
              "content": "ACE does not sell, rent, or trade personal data to third parties. Information is shared only:",
              "points": [
                "With event organizers and collaborators for event execution",
                "With service providers for essential platform operations",
                "When required by law or legal process"
              ]
            },
            {
              "title": "Legal and Safety Disclosures",
              "content": "We may disclose information if necessary to:",
              "points": [
                "Comply with legal obligations or court orders",
                "Enforce platform policies and terms",
                "Protect the rights, property, or safety of ACE, its users, or the public"
              ]
            }
          ]
        },
        {
          "sectionTitle": "6. Cookies and Tracking Technologies",
          "content": "ACE uses cookies and similar technologies to:",
          "points": [
            "Remember user preferences",
            "Enable core platform functionality",
            "Analyze traffic and user behavior"
          ],
          "note": "You may control or disable cookies through your browser settings; however, some features of the platform may not function properly as a result."
        },
        {
          "sectionTitle": "7. Children’s Privacy",
          "content": "ACE does not knowingly collect personal information from children under the age of 13 without verified parental or legal guardian consent. If such information is identified, it will be promptly deleted."
        },
        {
          "sectionTitle": "8. Changes to This Privacy Policy",
          "content": "ACE reserves the right to update or modify this Privacy Policy at any time. Significant changes will be communicated through the platform or via email. Continued use of ACE after updates constitutes acceptance of the revised Privacy Policy."
        },
        {
          "sectionTitle": "9. Contact Information",
          "content": "For any questions, concerns, or requests related to this Privacy Policy or your data, please contact All College Event support through the official platform channels."
        }
      ],
      "acknowledgment": "By using All College Event (ACE), you acknowledge that you have read, understood, and agreed to this Privacy Policy."
    }
  };

  @override
  Widget build(BuildContext context) {
    final policy = privacyPolicyJson['privacyPolicy'];
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            policy['title'],
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: MyColor().blackClr,
            ),
          ),

          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text(
              policy['intro'],
              textAlign: TextAlign.justify,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: MyColor().blackClr,
              ),
            ),
          ),

          ...List.from(
            (policy['sections'] ?? []).map((section) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Text(
                      section['sectionTitle'],
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: MyColor().primaryClr,
                      ),
                    ),
                  ),

                  ...List.from(
                    (section['subsections'] ?? []).map((sub) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                              sub['title'] ?? '',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: MyColor().blackClr,
                              ),
                            ),
                          ),

                          if (sub['content'] != null)
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              child: Text(
                                sub['content'],
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: MyColor().blackClr,
                                ),
                              ),
                            ),

                          if (sub['points'] != null)
                            ...List.from(
                              (sub['points'] as List<dynamic>).map((point) {
                                return Container(
                                  margin: const EdgeInsets.only(left: 16, top: 3),
                                  child: Text(
                                    "• $point",
                                    textAlign: TextAlign.justify,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              }),
                            ),

                          if (sub['note'] != null)
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              child: Text(
                                sub['note'],
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: MyColor().blackClr,
                                ),
                              ),
                            ),
                        ],
                      );
                    }),
                  ),

                  if (section['points'] != null)
                    ...List.from(
                      (section['points'] ?? []).map((point) {
                        return Container(
                          margin: const EdgeInsets.only(left: 16, top: 3),
                          child: Text(
                            "• $point",
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }),
                    ),

                  if (section['note'] != null)
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Text(
                        section['note'],
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: MyColor().blackClr,
                        ),
                      ),
                    ),

                  if (section['content'] != null)
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Text(
                        section['content'],
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: MyColor().blackClr,
                        ),
                      ),
                    ),
                ],
              );
            }),
          ),

          if (policy['acknowledgment'] != null)
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Text(
                policy['acknowledgment'],
                textAlign: TextAlign.justify,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: MyColor().blackClr,
                ),
              ),
            ),
        ],
      ),

    );
  }
}
