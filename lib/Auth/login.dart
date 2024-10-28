import 'package:task/Exports/MyExports.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool isShow = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 25),
            Text(
              "Welcome Back Let's Login",
              style: GoogleFonts.inter(
                  textStyle:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 35),
            TextField(
              controller: email,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_2_outlined),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Entar Your Email',
                  label: Text("Email"),
                  border: OutlineInputBorder()),
            ),
            SizedBox(height: 15),
            TextField(
              controller: pass,
              obscureText: isShow,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(Icons.lock_open),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.remove_red_eye_outlined),
                    onPressed: () {
                      isShow = !isShow;
                    },
                  ),
                  hintText: 'Entar Your Password',
                  label: Text("Password"),
                  border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            Container(
                alignment: Alignment.bottomRight,
                child: Text("Forget Password")),
            SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  activeColor: Colors.green,
                  value: isShow,
                  onChanged: (bool? value) {
                    setState(() {
                      isShow = value!;
                    });
                  },
                ),
                Text("I Agree with Terms & Conditions")
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MyHome()));
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            SizedBox(height: 10),
            Text("Don't have Account? Sign Up"),
            Expanded(child: Container()),
            Text(
              "Develop and Design By Samir Khan",
              style: GoogleFonts.inter(
                  textStyle:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}
