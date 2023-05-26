import 'package:database/ui/utils/HomePage_model.dart';
import 'package:flutter/material.dart';

/*   bir nechta  TextFormFieldni key ni bittada boshqarish  */

// class HomePage1 extends StatefulWidget {
//   const HomePage1({super.key});

//   @override
//   State<HomePage1> createState() => _HomePage1State();
// }

// class _HomePage1State extends State<HomePage1> {
//   TextEditingController textEditingController = TextEditingController();
//   GlobalKey<FormState> formkey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Problem "),
//       ),
//       body: Form(
//         key: formkey,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextFormField(
//               decoration: const InputDecoration(hintText: "Ismingiz"),
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return "Bosh Qoldirmang";
//                 } else {
//                   return null;
//                 }
//               },
//             ),
//             TextFormField(
//               decoration: const InputDecoration(hintText: "Familyangiz"),
//             ),
//             TextFormField(
//               decoration: const InputDecoration(hintText: "Yoshingiz"),
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return "Bosh Qoldirmang";
//                 } else {
//                   return null;
//                 }
//               },
//             ),
//             TextFormField(
//               decoration: const InputDecoration(hintText: "Tug'ilgan kuningiz"),
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return "Bosh Qoldirmang";
//                 } else {
//                   return null;
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           if (formkey.currentState!.validate()) {
//             print("OK");
//           }
//         },
//         label: const Text("Confirm"),
//       ),
//     );
//   }
// }


/*   List Elementiga bosilish holati  */


class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List "),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(HomePageModels.tasks[index]),
            trailing: InkWell(
              onTap: () {
                HomePageModels.changeCheckStatus(index);
                setState(() {});
              },
              child: CircleAvatar(
                backgroundColor:
                    HomePageModels.checkList[index] ? Colors.blue : Colors.red,
              ),
            ),
          );
        },
        itemCount: HomePageModels.tasks.length,
      ),
    );
  }
}
