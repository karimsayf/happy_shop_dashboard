import 'package:flutter/material.dart';

import '../../../components/custom_title.dart';
import '../../../utilities/colors.dart';
import '../../../utilities/size_utility.dart';
import 'auth_form.dart';

class AuthDesktopView extends StatelessWidget {
  const AuthDesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: getSize(context).width * 0.5,
                height: getSize(context).height,
                decoration: const BoxDecoration(
                    color: AppColors.mainColor,
                    image: DecorationImage(
                        image: AssetImage("assets/images/auth_bg.webp"),
                        fit: BoxFit.contain,
                        alignment: Alignment.topCenter)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 120,),
                    Row(
                      children: [
                        Expanded(
                          child: Image.asset(
                            "assets/images/ipad.webp",
                            fit: BoxFit.cover,
                            scale: 10.0,
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomTitle(
                            text: "مرحبا بكم ف ارتاح",
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: AppColors.c555,
                          ),
                          SizedBox(
                            width: 330,
                            child: const CustomTitle(
                              text:
                                  "مع ارتاح نضمن لك أسهل وأسرع طريقة لحجز خدمات منزلية تلبي احتياجاتك بكل سهولة. تجربتك معنا ستكون سريعة ومريحة!",
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: AppColors.c555,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsetsDirectional.only(start: getSize(context).width * 0.07),
                child: AuthForm(
                            width: getSize(context).width * 0.3,
                          ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
