/*
Column(
mainAxisAlignment: MainAxisAlignment.center,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
'Attention !',
style: TextStyle(
fontSize: 25,
fontWeight: FontWeight.bold,
color: Color(0xffF00000),
),
),
Text(
'- If you are in an emergency, please press this button.',
style: TextStyle(
fontSize: 16,
),
),
Text(
'- This button will notify emergency services.',
style: TextStyle(
fontSize: 16,
),
),
Text(
'Please only press this button in an emergency.',
style: TextStyle(
fontSize: 16,
),
),
Text(
'Emergencies include:',
style: TextStyle(
fontSize: 16,
),
),
Text(
'* Fire',
style: TextStyle(
fontSize: 16,
),
),
Text(
'* Medical emergency',
style: TextStyle(
fontSize: 16,
),
),
Text(
'* Natural disaster',
style: TextStyle(
fontSize: 16,
),
),
Text(
'- If you are in an emergency, please do not panic and try to stay calm.',
style: TextStyle(
fontSize: 16,
),
),
Text(
'Pressing this button will help you.',
style: TextStyle(
fontSize: 16,
),
),
],
),



          child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      boxShadow:[
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(0.0,10.0),
                          blurRadius: 10.0,
                        )
                      ],
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors:[Color(0xffF00000),Color(0xffDC281E)],
                      )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 125,
                          height: 125,
                          child: Image.asset("iconlar/acil_icon.png")),
                    ],
                  ),
                )
*/