class Item {
  String image;
  String title;
  String subtitle;
  Item({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}

List<Item> items = [
  Item(
      image: 'assets/images/online-tax.png',
      title: 'Taxation',
      subtitle:
          'Comprehensive solutions for direct and indirect taxes including tax planning, filing, representation, and advisory.'),
  Item(
      image: 'assets/images/earning.png',
      title: 'Company Incorporation & Compliance',
      subtitle:
          'Assistance with company formation, ROC filings, secretarial compliance, and regulatory adherence under the Companies Act.'),
  Item(
      image: 'assets/images/trend.png',
      title: 'Financial & Business Advisory',
      subtitle:
          'Strategic advice for business growth, financial restructuring, budgeting, and performance analysis.'),
  Item(
      image: 'assets/images/stats.png',
      title: 'Valuation Services',
      subtitle:
          'Business, asset, and share valuation for mergers, acquisitions, regulatory needs, or investment planning.'),
  Item(
      image: 'assets/images/check-list.png',
      title: 'Audit',
      subtitle:
          'Enhancing financial transparency through statutory, internal, and management audits to ensure compliance and build stakeholder trust.'),
  Item(
      image: 'assets/images/discussion.png',
      title: 'Internal Controls & Risk Management',
      subtitle:
          'Designing and reviewing internal controls to mitigate risk, enhance efficiency, and ensure operational integrity.')
];
