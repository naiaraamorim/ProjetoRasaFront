import 'package:flutter/material.dart';

class TelaSelect extends StatefulWidget {
  const TelaSelect({super.key});

  @override
  State<TelaSelect> createState() => _TelaSelectState();
}

class _TelaSelectState extends State<TelaSelect> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 50),
            child: Text(
              'Bem-vindo a seleção de atendimentos!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 28,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: SizedBox(
              width: 150,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        4), // Ajusta este valor para 0 para tornar os botões quadrados
                  ),
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 25),
                  backgroundColor: const Color.fromARGB(255, 189, 26, 34),
                ),
                onPressed: () {},
                child: const Text('NBS'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: SizedBox(
              width: 150,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        4), // Ajusta este valor para 0 para tornar os botões quadrados
                  ),
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 20),
                  backgroundColor: const Color.fromARGB(255, 189, 26, 34),
                ),
                onPressed: () {},
                child: const Text('INTRANET'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: SizedBox(
              width: 150,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        4), // Ajusta este valor para 0 para tornar os botões quadrados
                  ),
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 20),
                  backgroundColor: const Color.fromARGB(255, 189, 26, 34),
                ),
                onPressed: () {},
                child: const Text('REMOTO'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
