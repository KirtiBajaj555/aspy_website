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
    title: 'Taxation Services',
    subtitle: '''
Direct Tax Services:
• Filing Tax Returns - Corporate and Non-Corporate
• Advice on payment of advance tax
• Tax planning - Corporate and Non-Corporate
• TDS Compliance services
• Structuring employee emoluments
• Bulk filing of employee returns
• Fringe Benefit Tax compliances

Indirect Tax Services:
• Sales Tax/VAT registration and compliance across states
• Compliance with Foreign Trade Policies
• Service Tax registration and compliance
''',
  ),
  Item(
    image: 'assets/images/earning.png',
    title: 'Legal,Secretarial & Litigation',
    subtitle:'''• Company registration and incorporation
• Documentation and ROC filing for compliance
• Drafting Subscription and Shareholders Agreements
• Drafting legal and business agreements
• Setup of branch, liaison, or project offices in India

Litigation Services:
• Review of past tax assessments  
• Drafting submissions and appeal grounds  
• Representation before tax appellate authorities
• Assistance in tax litigation matters
''',
  ),

  Item(
    image: 'assets/images/trend.png',
    title: 'Finance & Accounting',
    subtitle:'''• Finance & Accounts management
• Direct and indirect tax compliance
• Fixed assets management
• Reconciliation: parties, banks, intercompanies
• MIS reporting and budgeting
• Vendor management
• Cash flow and fund flow management
• Preparation of annual accounts
• Maintenance of accounting records''',
  ),
  Item(
    image: 'assets/images/stats.png',
    title: 'Valuation Services',
    subtitle:'''• Valuation under Companies Act for shares, mergers, demergers, and liquidation.
• IBC valuations during insolvency and voluntary liquidation.
• SEBI-related valuations for delisting, ESOPs, takeovers, and compliance.
• RBI/FEMA valuations for FDI, FPI, cross-border deals, and asset sales.
• Income Tax valuations under Section 56, 50CA, etc.
• Valuation for M&A, ESOPs, estate planning, and strategic decisions.''',
  ),
  Item(
    image: 'assets/images/check-list.png',
    title: 'Audit & Assurance',
    subtitle:'''
• Statutory audits for true and fair financial reporting  
• Internal audits for risk and control assessment  
• Tax audits under Section 44AB of Income Tax Act  
• Compliance and secretarial audits  
• System audits for processes and controls  
• Stock audits with detailed inventory evaluation  
• Bank audits: concurrent, revenue, and stock audits  
• Forensic audits as per RBI guidelines
''',
  ),
  Item(
    image: 'assets/images/discussion.png',
    title: 'Payroll Processing',
    subtitle:'''
• Salary structure and breakup planning
• Salary master and monthly payroll preparation
• Tax withholding and secure payslip generation
• Salary disbursement via bank transfer advice
• Income Tax forms and compliance
''',
  ),
  
];
