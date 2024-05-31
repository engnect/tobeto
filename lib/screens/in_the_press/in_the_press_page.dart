import 'package:flutter/material.dart';
import 'package:tobeto/constants/assets.dart';
import 'package:tobeto/screens/in_the_press/widgets/in_the_press_card.dart';

class InThePressPage extends StatelessWidget {
  const InThePressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(247, 242, 242, 1),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Text(
                  "Basında Biz",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 35,
                  ),
                ),
              ),
              InThePressCard(
                image: Assets.ilkbulusma,
                date: "7 Ekim 2023",
                title: "İlk Kampüs Buluşması Gerçekleşti",
                content:
                    "İstanbul Kodluyor projesi kapsamında Türkiye'nin dört bir yanından gençler İstanbul'da bir araya geldi.",
                ontap: () {},
              ),
              InThePressCard(
                image: Assets.istanbulkodluyor,
                date: "15 Ağustos 2023",
                title:
                    "Türkiye’nin İlk Sosyal Etki Tahvili: İstanbul Kodluyor Projesi",
                content:
                    'Sanayi ve Teknoloji Bakanlığı Kalkınma Ajansları Genel Müdürlüğü koordinasyonunda İstanbul Kalkınma Ajansı (İSTKA) ve İngiltere merkezli Bridges Outcomes Partnerships iş birliğinde başlıyor.“Türkiye’nin İlk Sosyal Etki Tahvili: İstanbul Kodluyor Projesi” ile 18-35 yaş aralığında 550 gencin kapsamlı eğitimin ardından bilgi ve iletişim teknolojileri sektöründe istihdam edilmesi hedefleniyor. 1 milyon 250 bin dolarlık bütçeye sahip projenin açılış toplantısı, Sanayi ve Teknoloji Bakanı Mehmet Fatih Kacır’ın katılımıyla Boğaziçi Üniversitesi ev sahipliğinde 14 Ağustosta Albert Long Hall Binasında düzenlendi.',
                ontap: () {},
              ),
              InThePressCard(
                image: Assets.lansman,
                date: "14 Ağustos 2023",
                title: "İstanbul Kodluyor Proje Lansmanı",
                content:
                    "Türkiye’nin İlk Sosyal Etki Tahvili: “İstanbul Kodluyor” Projesi Sanayi ve Teknoloji Bakanlığı Kalkınma Ajansları Genel Müdürlüğü koordinasyonunda İstanbul Kalkınma Ajansı (İSTKA) ve İngiltere merkezli Bridges Outcomes Partnerships iş birliğinde başlıyor.",
                ontap: () {},
              ),
              InThePressCard(
                image: Assets.bogazicilansman,
                date: "14 Ağustos 2023",
                title:
                    "Boğaziçi Üniversitesi'nde Basın Lansmanı gerçekleştirildi",
                content:
                    "Sanayi ve Teknoloji Bakanlığı ile İstanbul Kalkınma Ajansı (İSTKA) iş birliğiyle hayata geçen “Türkiye’nin İlk Sosyal Etki Tahvili: İstanbul Kodluyor Projesi” ile 18-35 yaş aralığında 550 gencin kapsamlı eğitimin ardından bilgi ve iletişim teknolojileri sektöründe istihdam edilmesi hedefleniyor. 1 milyon 250 bin dolarlık bütçeye sahip projenin açılış toplantısı, Sanayi ve Teknoloji Bakanı Mehmet Fatih Kacır’ın katılımıyla Boğaziçi Üniversitesi ev sahipliğinde 14 Ağustos’ta Albert Long Hall Binası’nda düzenlendi. Toplantıya Boğaziçi Üniversitesi Rektörü Prof. Dr. Mehmet Naci İnci, Rektör Yardımcıları Prof. Dr. Gürkan Selçuk Kumbaroğlu ile Prof. Dr. Fazıl Önder Sönmez ile İstanbul Valisi Davut Gül de katıldı.",
                ontap: () {},
              ),
              InThePressCard(
                image: Assets.tobetoekip,
                date: "14 Ağustos 2023",
                title:
                    "TOBETO & Enocta İstanbul Kodluyor Projesinin Uygulayıcısı olacak",
                content:
                    "Tobeto & Enocta olarak Türkiye’nin ilk sosyal etki tahvili olan İstanbul Kodluyor Projesi’nin uygulayıcısı olmaktan gurur duyuyoruz!Sosyal Etki Tahvilleri, sosyal sorunlara çözüm bulan performansa dayalı sözleşmeler olup topluma ve özellikle gençlere yönelik projeleri destekleyerek istihdam ve eğitim gibi alanlarda olumlu etkiler yaratacak sonuçlara ulaşılmayı hedefler.İstanbul Kodluyor Türkiye’nin bu kapsamda hayata geçirilen ilk sosyal etki tahvili projesidir.Tüm paydaşlarla birlikte aylarca çalıştığımız İstanbul Kodluyor projesinin lansmanı dün Boğaziçi Üniversitesi’nde gerçekleşti.Sanayi ve Teknoloji Bakanlığı Kalkınma Ajansları Genel Müdürlüğü, İstanbul Kalkınma Ajansı Istanbul Development Agency , Bridges Outcomes Partnerships, Etkiyap ve Enocta & Tobeto iş birliğiyle; “ne eğitimde ne istihdamda” (NEET) olan gençlerin yazılım alanında yetiştirilmesi ve istihdam edilmesi için harika bir programa başlıyoruz.",
                ontap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
