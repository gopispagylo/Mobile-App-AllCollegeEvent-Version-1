import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsConditionModel extends StatefulWidget {
  const TermsConditionModel({super.key});

  @override
  State<TermsConditionModel> createState() => _TermsConditionModelState();
}

class _TermsConditionModelState extends State<TermsConditionModel> {
  // ------------- Sample JSON converted ----------
  Map<String, dynamic> termsAndCondition = {
    "termsAndConditions": {
      "title": "All College Event (ACE)",
      "company": "ECLearnix EdTech Private Limited",
      "sections": [
        {
          "sectionTitle": "1. Introduction & Legal Agreement",
          "subsections": [
            {
              "title": "1.1 Platform Overview",
              "content":
                  "All College Event (ACE), a product of ECLearnix EdTech Private Limited, is a digital platform for listing, discovering, promoting, and facilitating a wide range of academic and non-academic events, including educational, professional, cultural, technical, creative, entertainment, and community-based events.",
            },
            {
              "title": "1.2 Acceptance of Terms",
              "content":
                  "By accessing or using the ACE website or mobile application, you agree to be legally bound by these Terms & Conditions, along with the Privacy Policy and No-Refund Policy.",
            },
            {
              "title": "1.3 Binding Nature",
              "content":
                  "Your continued use of the platform confirms that you have read, understood, and accepted these Terms & Conditions in full.",
            },
          ],
        },
        {
          "sectionTitle": "2. Purpose of the Platform & Scope of Services",
          "subsections": [
            {
              "title": "2.1 Role of ACE",
              "content":
                  "ACE functions solely as a technology intermediary that enables event discovery, listing, and registration. ACE does not own, host, manage, or conduct any events.",
            },
            {
              "title": "2.2 Event Coverage",
              "content":
                  "The platform supports both academic and non-academic events, including conferences, workshops, FDPs, STTPs, hackathons, seminars, concerts, exhibitions, competitions, meetups, and commercial events.",
            },
            {
              "title": "2.3 Open Participation",
              "content":
                  "Participation on ACE is open to students, professionals, faculty, creators, entrepreneurs, freelancers, institutions, and the general public, unless explicitly restricted by the event organizer.",
            },
          ],
        },
        {
          "sectionTitle": "3. User Eligibility, Accounts & Responsibilities",
          "subsections": [
            {
              "title": "3.1 Eligibility Criteria",
              "content":
                  "The platform is intended for users aged 18 years and above. Users below 18 may participate only with parental or legal guardian consent, subject to organizer-defined rules.",
            },
            {
              "title": "3.2 Account Registration",
              "content":
                  "Users must register using accurate, complete, and up-to-date information to access features such as event registration, ticket booking, or event creation.",
            },
            {
              "title": "3.3 Account Security & Responsibility",
              "content":
                  "Users are responsible for maintaining the confidentiality of login credentials and all activities performed through their account.",
            },
            {
              "title": "3.4 Account Misuse",
              "content":
                  "Accounts with false, misleading, fraudulent, or unauthorized activity may be suspended or permanently terminated without prior notice.",
            },
          ],
        },
        {
          "sectionTitle": "4. Event Creation, Registration & Participation",
          "subsections": [
            {
              "title": "4.1 Organizer Eligibility & Collaboration",
              "content":
                  "Any individual, group, institution, or organization may create and publish events. Organizers may collaborate with co-hosts, sponsors, or partners, with joint responsibility for event accuracy and execution.",
            },
            {
              "title": "4.2 Event Information Accuracy",
              "content":
                  "Organizers must provide complete and truthful event details, including title, description, date, time, venue, mode, pricing, eligibility, and applicable policies.",
            },
            {
              "title": "4.3 Organizer Responsibilities",
              "content":
                  "Organizers are solely responsible for event planning, execution, safety, permissions, legal compliance, and intellectual property rights.",
            },
            {
              "title": "4.4 Event Registration & Attendance",
              "content":
                  "Event registration is confirmed only upon successful completion of the registration or payment process. Participation, certificates, and outcomes are managed exclusively by the organizer.",
            },
          ],
        },
        {
          "sectionTitle": "5. Payments, Monetization & Refund Policy",
          "subsections": [
            {
              "title": "5.1 Platform Fees & Services",
              "content":
                  "ACE may introduce platform fees, premium listings, subscriptions, promotional tools, or convenience charges at its discretion.",
            },
            {
              "title": "5.2 No-Refund Policy",
              "content":
                  "All payments made through the platform are governed by the No-Refund Policy unless explicitly stated otherwise by the event organizer.",
            },
            {
              "title": "5.3 Organizer Financial Responsibility",
              "content":
                  "Refunds, if applicable, are the sole responsibility of the event organizer. ACE is not liable for payment disputes between participants and organizers.",
            },
          ],
        },
        {
          "sectionTitle":
              "6. Content Ownership, Intellectual Property & Disclaimers",
          "subsections": [
            {
              "title": "6.1 User-Generated Content",
              "content":
                  "Organizers retain ownership of uploaded content but grant ACE a non-exclusive, worldwide, royalty-free license to host, display, promote, and distribute such content.",
            },
            {
              "title": "6.2 Third-Party Rights",
              "content":
                  "Organizers are responsible for ensuring content does not infringe on third-party intellectual property or privacy rights.",
            },
            {
              "title": "6.3 Platform & Third-Party Disclaimer",
              "content":
                  "ACE is not an organizer, co-organizer, sponsor, or participant in any event and bears no responsibility for event quality, safety, cancellations, or outcomes.",
            },
          ],
        },
        {
          "sectionTitle": "7. Liability, Modifications & Governing Law",
          "subsections": [
            {
              "title": "7.1 Limitation of Liability",
              "content":
                  "ACE shall not be liable for any direct or indirect damages arising from event participation, organizer actions, cancellations, or third-party services.",
            },
            {
              "title": "7.2 Indemnification",
              "content":
                  "Users and organizers agree to indemnify and hold ACE harmless from any claims resulting from their actions or violations.",
            },
            {
              "title": "7.3 Modifications & Termination",
              "content":
                  "ACE reserves the right to modify these Terms & Conditions and suspend or terminate accounts for violations, misuse, or legal non-compliance.",
            },
            {
              "title": "7.4 Governing Law & Jurisdiction",
              "content":
                  "These Terms & Conditions are governed by the laws of India, with exclusive jurisdiction vested in the courts of Coimbatore, Tamil Nadu.",
            },
          ],
        },
      ],
    },
  };

  @override
  Widget build(BuildContext context) {
    final list = termsAndCondition['termsAndConditions'];
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: ListView(
        children: [
          Text(
            list['title'],
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: MyColor().blackClr,
            ),
          ),
          ...List.from(
            (list['sections'] ?? []).map((section) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
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
                    (section['subsections'] ?? []).asMap().entries.map((entry) {
                      final index = entry.key;
                      final sub = entry.value;
                      final isLast =
                          index == section['subsections']?.length - 1;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10),
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
                              margin: EdgeInsets.only(
                                top: 5,
                                bottom: isLast ? 16 : 0,
                              ),
                              child: Text(
                                textAlign: TextAlign.justify,
                                sub['content'] ?? '',
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
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
