#!/usr/bin/python
import os

'             prefix,  name,   start, end  '
pages_internal=['01,table_of_contents,1,3',
                '03,personalstatement,14,15',
                '04,teaching,16,24',
                '05,research,25,32',
                '06,service,33,36',
                '07,appendix-1-teaching,36,46',
                '08,appendix-1-research,47,54',
                ]
pages_external=['01,table_of_contents,1,3', 
                '03,personalstatement,14,15',
                '04,research,16,23',
                '05,service,24,27',
                '06,appendix-1-research,27,34',
                ]

def sysdo(ss):
    print(ss)
    os.system(ss)
for dprefix,folder,lof in [['int','internal/',pages_internal],
                          ['ext','external/',pages_external],]:
    sysdo(' rm '+folder+'*')    
    assert not os.listdir(folder)
    for  prefix,name,start,end in [LL.split(',') for LL in lof]:
        sysdo("""
        """+ "pdftk "+dprefix+"_ChristopherBarrington-Leigh_entire_dossier.pdf cat "+start+'-'+end+" output "+folder+prefix+'_'+dprefix+'_ChristopherBarrington-Leigh_'+name+'.pdf'+"""
        """)
        # Also store the first page in order to do a quick check, later, that
        sysdo(' pdftk  '+folder+prefix+'_'+dprefix+'_ChristopherBarrington-Leigh_'+name+'.pdf   cat 1  output textrash/'+prefix+'_'+dprefix+'_ChristopherBarrington-Leigh_'+name+'_p1.pdf')

    sysdo(' cp -a ../tenure-cv.pdf '+folder+'02_'+dprefix+"_ChristopherBarrington-Leigh_cv.pdf")
    sysdo(' cp -a '+dprefix+"_ChristopherBarrington-Leigh_entire_dossier.pdf  "+folder)

# Now make a quick inspection test to make sure we got all the page numbers right
sysdo('pdftk textrash/*int*_p1.pdf textrash/*ext*_p1.pdf cat output tmp_check_pages.pdf')
sysdo(' evince tmp_check_pages.pdf &')
