import 'package:flutter/material.dart';
import 'package:todo_portifolio/widgets/animated_background.widget.dart';

class TabTwo extends StatelessWidget {
  final headerTextStyle = TextStyle(
      color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600);

  cardResume(BuildContext context) {
    final avaliableHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Container(
        margin: EdgeInsets.only(left: 35.0),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(8),
          shape: BoxShape.rectangle,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width / 2,
        height: avaliableHeight * 0.5,
        child: customCardContentWhoIs());
  }

  Widget customCardContentWhoIs() {
    const _resume =
        "Analista desenvolvedor Java. Graduado na área. Experiência em desenvolvimento de aplicações web,batchs e automatização de rotinas através de scripts. Conhecimento em diversas ferramentas de integração contínua, criação de testes unitários e vivência com sistemas baseados em Linux e Windows.";

    return Container(
      margin: EdgeInsets.only(left: 25.0, top: 20, bottom: 20, right: 20),
      child: Wrap(verticalDirection: VerticalDirection.down, children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Quem Sou?",
              style: headerTextStyle,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              _resume,
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Informações de Contato",
              style: headerTextStyle,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "E-mail: kaio.felix.oliveira.mail@gmail.com",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 15),
            ),
            Text(
              "Skype: kaiofelixdeoliveira",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ]),
    );
  }

  tabTwo(BuildContext context) {
    return Stack(
      children: <Widget>[
        FancyBackgroundApp(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    cardResume(context),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return tabTwo(context);
  }
}
