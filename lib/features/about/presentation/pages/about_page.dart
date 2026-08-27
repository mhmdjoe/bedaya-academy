import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:amr/core/theme/app_theme.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('عن منصة بداية'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.canPop() ? context.pop() : context.go('/'),
        ),
        actions: [
          IconButton(
            icon: ClipOval(
              child: Image.asset('assets/images/logo.png', height: 30, width: 30, fit: BoxFit.cover),
            ),
            onPressed: () => context.go('/'),
            tooltip: 'الرئيسية',
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildAboutHero(context),
            _buildValuesSection(context),
            _buildFreeSessionOffer(context),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutHero(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 600;
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: isMobile ? 60 : 80, horizontal: 20),
      decoration: BoxDecoration(
        color: AppTheme.primaryBlue,
        image: DecorationImage(
          image: const AssetImage('assets/images/logo.png'),
          opacity: 0.05,
          repeat: ImageRepeat.repeat,
          scale: 0.5,
        ),
      ),
      child: Column(
        children: [
          Text(
            'قصة بداية',
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile ? 32 : 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Text(
              'ولدت منصة بداية من رؤية طموحة لتمكين الطلاب في الوطن العربي من الوصول إلى تعليم عالي الجودة يتجاوز الحدود التقليدية. نحن نؤمن أن التعليم هو مفتاح المستقبل، ونسعى لتوفير بيئة تعليمية تفاعلية تجمع بين أفضل المعلمين وأحدث الوسائل التكنولوجية.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: isMobile ? 16 : 20,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValuesSection(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 600;
    
    return Container(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 60 : 80, horizontal: 20),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            'ما الذي يميزنا؟',
            style: TextStyle(fontSize: isMobile ? 28 : 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 50),
          Wrap(
            spacing: 40,
            runSpacing: 40,
            alignment: WrapAlignment.center,
            children: [
              _buildValueCard(
                Icons.star_rounded,
                'نخبة المعلمين',
                'نختار معلمينا بعناية فائقة لضمان تقديم مادة علمية متميزة بأسلوب مبسط.',
              ),
              _buildValueCard(
                Icons.laptop_mac_rounded,
                'تعليم تفاعلي',
                'نستخدم أحدث الأدوات والوسائل التعليمية لجعل الحصص أكثر متعة وفعالية.',
              ),
              _buildValueCard(
                Icons.support_agent_rounded,
                'متابعة مستمرة',
                'نحن معك خطوة بخطوة، من خلال مجموعات الدراسة والدعم الأكاديمي المتواصل.',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildValueCard(IconData icon, String title, String description) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = MediaQuery.of(context).size.width <= 600;
        return SizedBox(
          width: isMobile ? double.infinity : 300,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppTheme.primaryBlue, size: 40),
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 16, height: 1.5),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFreeSessionOffer(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 600;

    return Container(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 60 : 80, horizontal: 20),
      color: AppTheme.backgroundLight,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Column(
          children: [
            Text(
              'هدية بداية: حصة مجانية تماماً',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: isMobile ? 24 : 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'نريدك أن تختبر الجودة التي نقدمها بنفسك. احجز حصتك التجريبية الأولى مجاناً دون أي التزامات.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: isMobile ? 16 : 18, color: Colors.grey),
            ),
            const SizedBox(height: 50),
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: EdgeInsets.all(isMobile ? 20 : 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'احجز حصتك الآن',
                      style: TextStyle(fontSize: isMobile ? 20 : 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 30),
                    const TextField(
                      decoration: InputDecoration(
                        labelText: 'الاسم بالكامل',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const TextField(
                      decoration: InputDecoration(
                        labelText: 'رقم الهاتف / واتساب',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const TextField(
                      decoration: InputDecoration(
                        labelText: 'المادة المهتم بها',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.book),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('تم إرسال طلبك بنجاح! سنتواصل معك قريباً.'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                        child: Text('تأكيد الحجز المجاني', style: TextStyle(fontSize: isMobile ? 16 : 18)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      width: double.infinity,
      color: AppTheme.primaryBlue,
      child: Column(
        children: [
          const Text(
            'Bidaya Academy © 2024',
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.facebook, color: Colors.white)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.camera_alt, color: Colors.white)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.alternate_email, color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}
