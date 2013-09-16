import survey
# table = survey.Pregnancies()
# table.ReadRecords()
# print u' pregnancies total count: ',len(table.records)


def PartitionRecords(table):
    """Devides records into two lists : first babies and others
    Only live births are included
    table : pregnancies table
    """
    firsts = survey.Pregnancies()
    others = survey.Pregnancies()
    for p in table.records:
        if p.outcome != 1:
            continue
        if p.birthord == 1:
            firsts.AddRecord(p)
        else:
            others.AddRecord(p)

    return firsts,others

def MakeTable(data_dir='.'):
    """record survey data and returns tables for first babies and others"""
    table = survey.Pregnancies()
    table.ReadRecords(data_dir)
    firsts,others = PartitionRecords(table)
    return table,firsts,others

def Summarize(data_dir):
    """print summary statistics for first babies and others.
       return : tuples of tables
    """

    table,firsts,others = MakeTable(data_dir)
    ProcessTable(firsts,others)

    print 'number of first babies',firsts.n
    print 'number of others',others.n

    mu1,mu2 = firsts.mu,others.mu

    print 'Mean gestation in weeks'
    print 'first babies ',mu1
    print 'others',mu2

    print 'Difference of days ', (mu1 - mu2)*7.0



def Mean(t):
    """Computing the mean of a sequence numbers"""
    return float(sum(t)) / len(t)

def ProcessTable(*tables):
    """processes a list of tables"""
    for table in tables:
        Process(table)



def Process(table):
    """Run analysys given table

    table : table object
    """
    table.length = [p.prglength for p in table.records]
    table.n = len(table.length)
    table.mu = Mean(table.length)

def main(name,data_dir='.'):
    Summarize(data_dir)

if __name__ == '__main__':
    import sys
    main(*sys.argv)
