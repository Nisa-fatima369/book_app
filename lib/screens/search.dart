import 'package:book_app/config/routes.dart';
import 'package:book_app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:book_app/widgets/constants.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _controller,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.selectedColor),
                      decoration: kGreyTextField.copyWith(
                        filled: true,
                        hintText: 'search',
                        prefixIcon:
                            Icon(Icons.search, color: AppColors.selectedColor),
                        suffixIcon: GestureDetector(
                          onTap: _controller.clear,
                          child: Icon(
                            Icons.cancel_rounded,
                            color: AppColors.selectedColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(Routes.pageVieew);
                    },
                    child: Text(
                      'cancel',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(fontSize: 18),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Books',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'see all',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.05),
              Text('Atmoic Books',
                  style: Theme.of(context).textTheme.titleMedium),
              Text('Atmoic Books',
                  style: Theme.of(context).textTheme.titleMedium),
              Text('Atmoic Books',
                  style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: size.height * 0.03),
              Divider(color: AppColors.selectedColor),
              SizedBox(height: size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Searches',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Delete history',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(fontSize: 18),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.04),
              Text('The beast', style: Theme.of(context).textTheme.titleMedium),
              Text('Dark French',
                  style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
      ),
    );
  }
}
