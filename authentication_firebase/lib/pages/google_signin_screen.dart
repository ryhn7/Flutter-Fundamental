part of 'pages.dart';

class GoogleSignInPage extends StatelessWidget {
  const GoogleSignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //* TITLE
            const Text(
              'SIGN IN WITH GOOGLE ACCOUNT',
            ),
            const SizedBox(height: 10),

            //* SIGN IN STATUS
            // CODE HERE: Change status based on current user
            StreamBuilder<User?>(
                stream: FirebaseAuth.instance.userChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                        "Signed in as ${snapshot.data?.displayName} (${snapshot.data?.email})", textAlign: TextAlign.center,);
                  } else {
                    return const Text("You haven't signed in yet");
                  }
                }),
            const SizedBox(height: 15),

            //* SIGN IN BUTTON
            SizedBox(
              width: 150,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.purple.shade900)),
                onPressed: () async {
                  // CODE HERE: Sign in with Google Credential / Sign out from firebase & Google
                  if (FirebaseAuth.instance.currentUser == null) {
                    GoogleSignInAccount? account =
                        await GoogleSignIn().signIn();

                    if (account != null) {
                      GoogleSignInAuthentication auth =
                          await account.authentication;
                      OAuthCredential credential =
                          GoogleAuthProvider.credential(
                        accessToken: auth.accessToken,
                        idToken: auth.idToken,
                      );

                      await FirebaseAuth.instance
                          .signInWithCredential(credential);
                    }
                  } else {
                    await GoogleSignIn().signOut();
                    await FirebaseAuth.instance.signOut();
                  }
                },
                // CODE HERE: Change button text based on current user
                child: StreamBuilder<User?>(
                    stream: FirebaseAuth.instance.userChanges(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return const Text(
                          "Sign Out",
                          style: TextStyle(color: Colors.white),
                        );
                      } else {
                        // CODE HERE: Sign in with email & password / Sign out form firebase
                        return const Text(
                          "Sign In",
                          style: TextStyle(color: Colors.white),
                        );
                      }
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
