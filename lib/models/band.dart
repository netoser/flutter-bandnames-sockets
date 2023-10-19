class Band {
  String id;
  String name;
  int votes;

  Band ({
    this.id='',
    this.name='',
    this.votes=0
  });

  factory Band.fromMap( Map<String, dynamic> obj) //factory Constructor regresa una nueva instancia de la clase
    => Band(
      id: obj['id'],
      name: obj['name'],
      votes: obj['votes']
    );

}