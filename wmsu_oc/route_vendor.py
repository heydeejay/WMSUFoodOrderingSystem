from flask import Flask,Blueprint, render_template, request, flash, redirect, url_for, jsonify,send_from_directory, make_response, session
from flask_login import login_required, current_user
from .models import *
from werkzeug.security import generate_password_hash, check_password_hash
from flask_login import login_user, login_required, logout_user, current_user
from sqlalchemy import delete, desc, asc
from sqlalchemy import delete
from sqlalchemy import select
import json
from os import path
import os
from io import TextIOWrapper
import csv
import io
import random
import base64
import datetime
from datetime import datetime, date,timedelta



USER_CONTENT_FOLDER = 'usercont'
if not os.path.exists(USER_CONTENT_FOLDER):
    os.path.makedirs(USER_CONTENT_FOLDER)
    print("User content folder generated.")

_route_vendor = Blueprint('_route_vendor', __name__)

flask_app = Flask(__name__) #Initialize flask_app

@_route_vendor.route('/vendor_page',methods=['POST','GET'])
def vendor_page():
    
    
    user_id = request.args.get('user_id')
    
    store=Vendor.query.filter(Vendor.user_id==user_id).first()
    food = Food.query.filter(Food.vendor_id ==user_id).all()
    user=User.query.filter_by(id=user_id).first()
    count=Delivery.query.filter(Delivery.vendor == store.store_name,Delivery.response=='pending').with_entities(Delivery.track_no).distinct().count()
    remit_count=Remittance.query.filter_by(vendor_name=store.store_name).count()
    return render_template("Vendor/vendor_dashboard.html",count=count,food=food,user_id=user_id,store=store,user=user,remit_count=remit_count)


@_route_vendor.route('/vendor_dashboard',methods=['POST','GET'])
def vendor_dashboard():
    
    store=Vendor.query.filter(Vendor.id==request.form['vendor_id']).first()
    food = Food.query.filter(Food.vendor_id ==store.user_id).all()
    user=User.query.filter_by(id=store.user_id).first()
    remit_count=Remittance.query.filter_by(vendor_name=store.store_name).count()

    count=Delivery.query.filter(Delivery.vendor == store.store_name,Delivery.response=='pending').with_entities(Delivery.track_no).distinct().count()
    return render_template("Vendor/vendor_dashboard.html",food=food,store=store,user=user,count=count,remit_count=remit_count)


@_route_vendor.route('/vendor_transaction',methods=['POST','GET'])
def vendor_transaction():
    
    store=Vendor.query.filter_by(id=request.form['vendor_id']).first()
    user=User.query.filter_by(id=store.user_id).first()
    
    remit_money=Remittance.query.filter_by(vendor_name=store.store_name).all()
    remit_count=Remittance.query.filter_by(vendor_name=store.store_name).count()
    count=Delivery.query.filter(Delivery.vendor == store.store_name,Delivery.response=='pending').with_entities(Delivery.track_no).distinct().count()
    return render_template("Vendor/vendor_transaction.html",user=user,store=store,remit_money=remit_money,count=count,remit_count=remit_count)

@_route_vendor.route('/vendor_transaction_done',methods=['POST','GET'])
def vendor_transaction_done():
    
    store=Vendor.query.filter_by(id=request.form['vendor_id']).first()
    
    track_delivery=Delivery.query.filter_by(vendor=store.store_name, mop="COD" ).all()
    total_sum = sum(order.total for order in track_delivery)
    remit=Remittance.query.all()
    # Assuming there is a common attribute like track_no
    common_track_numbers = [delivery.track_no for delivery in track_delivery]

    matching_remit_numbers = [r.track_no for r in remit if r.track_no in common_track_numbers]
    if matching_remit_numbers:
        remit_money = Remittance.query.filter(Remittance.track_no.in_(matching_remit_numbers)).all()
    else:
        remit_money = []
   
    remit_done=Remittance.query.filter_by(id=request.form['remit_id']).first()
    db.session.delete(remit_done)
    db.session.commit()
    count=Delivery.query.filter(Delivery.vendor == store.store_name).with_entities(Delivery.track_no).distinct().count()
    remit_count=Remittance.query.filter_by(vendor_name=store.store_name).count()
    return render_template("Vendor/vendor_transaction.html",count=count,track_delivery=track_delivery,total_sum=total_sum,remit_money=remit_money,store=store,remit_count=remit_count)

@_route_vendor.route('/vendor_sales',methods=['POST','GET'])
def vendor_sales():
    
    store=Vendor.query.filter_by(id=request.form['store_id']).first()
    user=User.query.filter_by(id=store.user_id).first()
    
    sale=Complete_Delivery.query.filter_by(vendor=store.store_name).all()
    total_sum = sum(order.total for order in sale)
    count=Delivery.query.filter(Delivery.vendor == store.store_name,Delivery.response=='pending').with_entities(Delivery.track_no).distinct().count()
    remit_count=Remittance.query.filter_by(vendor_name=store.store_name).count()
    return render_template("Vendor/vendor_sales.html",count=count,store=store,user=user,sale=sale,total_sum=total_sum,remit_count=remit_count)

@_route_vendor.route('/vendor_addfood',methods=['POST','GET'])
def vendor_addfood():
    
    
    store=Vendor.query.filter_by(id=request.form['store_id']).first()
    user=User.query.filter_by(id=store.user_id).first()
    remit_count=Remittance.query.filter_by(vendor_name=store.store_name).count()
    return render_template("Vendor/vendor_addfood.html",user=user,store=store, remit_count=remit_count)

@_route_vendor.route('/vendor_editfood',methods=['POST','GET'])
def vendor_editfood():
    
    
    store=Vendor.query.filter_by(id=request.form['store_id']).first()
    user=User.query.filter_by(id=store.user_id).first()

    food=Food.query.filter_by(id=request.form['food_id']).first()
    remit_count=Remittance.query.filter_by(vendor_name=store.store_name).count()
    return render_template("Vendor/vendor_editfood.html",user=user,store=store,food=food, remit_count=remit_count)

@_route_vendor.route('/edit_food', methods=['POST','GET'])
def edit_food():
        
        msg=''
        store=Vendor.query.filter_by(id=request.form['store_id']).first()
        user=User.query.filter_by(id=store.user_id).first()
        date = datetime.now()
        fname = None
        if 'file' in request.files:
            fname = handle_profile_submition(request.files['file'])
            if fname is None:
                print("error")

        #EDIT image
        image_full=os.path.join(USER_CONTENT_FOLDER, fname)

        # Find the index of "usercont" in the path
        index_of_usercont = image_full.find("usercont")

        # Extract the part of the path starting from "usercont"
        image = image_full[index_of_usercont:]

        food=Food.query.filter_by(id=request.form['food_id']).first() 
        food.food_name=request.form['food_name']
        food.price=request.form['price']
        food.status=request.form['food_status']
        food.category=request.form['category']
        food.image_url=image
        food.vendor_id=user.id
        food.date=date

        db.session.commit()
        msg='success'
        remit_count=Remittance.query.filter_by(vendor_name=store.store_name).count()
        return render_template("Vendor/vendor_editfood.html",user=user,store=store,food=food,msg=msg,remit_count=remit_count)


@_route_vendor.route('/vendor_delete_food', methods=['POST','GET'])
def vendor_delete_food():
        
        store=Vendor.query.filter_by(id=request.form['store_id']).first()
        print(request.form['store_id'])
        user=User.query.filter_by(id=store.user_id).first()
        food = Food.query.filter(Food.vendor_id ==store.user_id).all()
        food1=Food.query.filter(Food.id==request.form['food_id']).first()
        db.session.delete(food1)
        db.session.commit()
        msg='delete'
        
        count=Delivery.query.filter(Delivery.vendor == store.store_name).with_entities(Delivery.track_no).distinct().count()
        return render_template("Vendor/vendor_dashboard.html",msg=msg,store=store,user=user,count=count,food=food)
        
    

@_route_vendor.route('/add_food', methods=['POST','GET'])
def add_food():
    try:
        msg=''
        date = datetime.now()
        fname = None
        if 'file' in request.files:
            fname = handle_profile_submition(request.files['file'])
            if fname is None:
                print("error")

        #image
        image_full=os.path.join(USER_CONTENT_FOLDER, fname)

        # Find the index of "usercont" in the path
        index_of_usercont = image_full.find("usercont")

        # Extract the part of the path starting from "usercont"
        image = image_full[index_of_usercont:]
        

        new_food = Food(request.form['food_name'], request.form['price'], 'Available' ,request.form['category'],image,request.form['vendor_id'],0,date)
        db.session.add(new_food)
        db.session.commit()
        msg='success'

        store=Vendor.query.filter_by(id=request.form['store_id']).first()
        user=User.query.filter_by(id=store.user_id).first()
        count=Delivery.query.filter(Delivery.vendor == store.store_name).with_entities(Delivery.track_no).distinct().count()
        remit_count=Remittance.query.filter_by(vendor_name=store.store_name).count()
        return render_template("Vendor/vendor_addfood.html",user=user,store=store,msg=msg,count=count,remit_count=remit_count)
            
    except:
        msg='error'
        return render_template("Vendor/vendor_addfood.html",msg=msg)



@_route_vendor.route('/accept',   methods=['POST','GET'])
def accept():
    
    food_id=request.form['food_id']
    record_to_edit = Delivery.query.get(food_id)
    record_to_edit.response = 'Accepted'
    db.session.commit()
    
    store=Vendor.query.filter_by(id=request.form['vendor']).first()
    food = Delivery.query.filter(Delivery.vendor == store.store_name).all()
    count=Delivery.query.filter(Delivery.vendor == store.store_name).with_entities(Delivery.track_no).distinct().count()
    remit_count=Remittance.query.filter_by(vendor_name=store.store_name).count()
    return render_template("Vendor/vendor_transaction.html", count=count, store=store, food=food, remit_count=remit_count)

@_route_vendor.route('/vendor_pending_order', methods=['POST','GET'])
def vendor_pending_order():
    store=Vendor.query.filter_by(id=request.form['vendor_id']).first()
    user=User.query.filter_by(id=store.user_id).first()
    track = Delivery.query.filter(Delivery.vendor == store.store_name,Delivery.mop=="COD").with_entities(Delivery.track_no).distinct().all()
    track1 = Delivery.query.filter(Delivery.vendor == store.store_name, Delivery.mop=="pickup").with_entities(Delivery.track_no).distinct().all()
    count=Delivery.query.filter(Delivery.vendor == store.store_name,Delivery.food_ready=='no').with_entities(Delivery.track_no).distinct().count()
    pickup=Delivery.query.filter(Delivery.vendor == store.store_name,Delivery.mop=='pickup',Delivery.food_ready=='no').with_entities(Delivery.track_no).distinct().count()
    delivery=Delivery.query.filter(Delivery.vendor == store.store_name,Delivery.mop=='COD',Delivery.food_ready=='no').with_entities(Delivery.track_no).distinct().count()
    remit_count=Remittance.query.filter_by(vendor_name=store.store_name).count()
    return render_template("Vendor/vendor_pending_order.html", track=track,track1=track1, store=store,user=user,count=count,pickup=pickup,delivery=delivery,remit_count=remit_count)

@_route_vendor.route('/vendor_pending_order_details', methods=['POST','GET'])
def vendor_pending_order_details():
    print(request.form['track_no'])
    store=Vendor.query.filter_by(id=request.form['vendor_id']).first()
    user=User.query.filter_by(id=store.user_id).first()
    track = Delivery.query.filter(Delivery.track_no == request.form['track_no'], Delivery.vendor==store.store_name,Delivery.response=='pending').all()

    accepted_count= Delivery.query.filter_by(vendor=store.store_name, response='Accepted').count()
    msg=''
    accepted=''
    customer=''
    if accepted_count>0:
        msg='ready'
        accepted= Delivery.query.filter_by(vendor=store.store_name, response='Accepted').all()
        customer=Delivery.query.filter_by(vendor=store.store_name, response='Accepted').first()

    count=Delivery.query.filter(Delivery.vendor == store.store_name).with_entities(Delivery.track_no).distinct().count()
    remit_count=Remittance.query.filter_by(vendor_name=store.store_name).count()
    return render_template("Vendor/vendor_pending_order_details.html",count=count, track1=request.form['track_no'], store=store, track=track,accepted=accepted,msg=msg,customer=customer,user=user,remit_count=remit_count)


@_route_vendor.route('/accept_order', methods=['POST','GET'])
def accept_order():

    track_id=request.form['track_id']
    record_to_edit = Delivery.query.get(track_id)
    record_to_edit.response = 'Accepted'
    db.session.commit()    

    store=Vendor.query.filter_by(id=request.form['vendor_id']).first()
    user=User.query.filter_by(id=store.user_id).first()
    accepted_count= Delivery.query.filter_by(vendor=store.store_name, response='Accepted',mop ='pickup').count()
    msg=''
    accepted=''
    customer=''
    if accepted_count > 0:
        msg='accept'
        accepted= Delivery.query.filter_by(vendor=store.store_name, response='Accepted',mop ='pickup').all()
        customer=Delivery.query.filter_by(vendor=store.store_name, response='Accepted').first()
    count=Delivery.query.filter(Delivery.vendor == store.store_name).with_entities(Delivery.track_no).distinct().count()
    track = Delivery.query.filter(Delivery.track_no == request.form['track_no'], Delivery.vendor==store.store_name, Delivery.vendor==store.store_name,Delivery.response=='pending').all()
    remit_count=Remittance.query.filter_by(vendor_name=store.store_name).count()
    return render_template("Vendor/vendor_pending_order_details.html",count=count,track1=request.form['track_no'], store=store, track=track, accepted=accepted,msg=msg,customer=customer,user=user,res='y',remit_count=remit_count)


@_route_vendor.route('/cancel_order', methods=['POST','GET'])
def cancel_order():

    track_id=request.form['track_id']
    record_to_edit = Delivery.query.get(track_id)
    record_to_edit.response = 'Canceled'
    db.session.commit()

    store=Vendor.query.filter_by(id=request.form['vendor_id']).first()
    user=User.query.filter_by(id=store.user_id).first()
    track = Delivery.query.filter(Delivery.track_no == request.form['track_no'], Delivery.vendor==store.store_name, Delivery.vendor==store.store_name,Delivery.response=='pending').all()

    accepted_count= Delivery.query.filter_by(vendor=store.store_name, response='Accepted').count()
    msg=''
    accepted=''
    customer=''
    if accepted_count > 0:
        msg='accept'
        accepted= Delivery.query.filter_by(vendor=store.store_name, response='Accepted').all()
        customer=Delivery.query.filter_by(vendor=store.store_name, response='Accepted').first()
    count=Delivery.query.filter(Delivery.vendor == store.store_name).with_entities(Delivery.track_no).distinct().count()
    remit_count=Remittance.query.filter_by(vendor_name=store.store_name).count()
    return render_template("Vendor/vendor_pending_order_details.html",count=count,track1=request.form['track_no'], store=store, track=track, msg=msg, accepted=accepted,customer=customer,user=user,res='n',remit_count=remit_count)

@_route_vendor.route('/vendor_food_ready', methods=['POST','GET'])
def vendor_food_ready():

    track = Delivery.query.filter(Delivery.customer_id == request.form['customer_id']).first()
    customer = User.query.filter(User.id == track.customer_id).first()
    store=Vendor.query.filter_by(id=request.form['vendor_id']).first()
    user=User.query.filter_by(id=store.user_id).first()
    track1 = Delivery.query.filter(Delivery.track_no == request.form['track_no']).first()
    tracks=Delivery.query.filter(Delivery.track_no == request.form['track_no'],Delivery.vendor == store.store_name).all()
    records_to_update = Delivery.query.filter(Delivery.track_no == request.form['track_no'],Delivery.vendor==store.store_name).all()

    for record in records_to_update:
        record.food_ready = 'yes'
    
    # After making changes, commit the updates to the database.
    db.session.commit()

    count=Delivery.query.filter(Delivery.vendor == store.store_name).with_entities(Delivery.track_no).distinct().count()
    remit_count=Remittance.query.filter_by(vendor_name=store.store_name).count()
    return render_template("Vendor/vendor_food_ready.html",count=count,customer=customer,store=store,track1=track1,user=user,remit_count=remit_count,tracks=tracks)


@_route_vendor.route('/vendor_remittance', methods=['POST','GET'])
def vendor_remittance():
    track = Delivery.query.filter(Delivery.track_no == request.form['track_no']).first()
    store=Vendor.query.filter_by(id=request.form['vendor_id']).first()
    user=User.query.filter_by(id=store.user_id).first()
    orderlist = Delivery.query.filter(Delivery.track_no == request.form['track_no'], Delivery.response=='Accepted',Delivery.vendor==store.store_name).all()
    total_sum = sum(order.total for order in orderlist)

    for orderlist1 in orderlist:
            orderlist1.payment = 'yes'

        # After making changes, commit the updates to the database.
    db.session.commit()
    
    customer = User.query.filter(User.id == track.customer_id).first()
    
    count=Delivery.query.filter(Delivery.vendor == store.store_name).with_entities(Delivery.track_no).distinct().count()
    remit_count=Remittance.query.filter_by(vendor_name=store.store_name).count()
    return render_template("Vendor/vendor_remittance.html",count=count,track=track,total_sum=total_sum,customer=customer,store=store,user=user,remit_count=remit_count)

@_route_vendor.route('/vendor_remit',methods=['POST','GET'])
def vendor_remit():
 
    store=Vendor.query.filter_by(id=request.form['vendor_id']).first()
    user=User.query.filter_by(id=store.user_id).first()
    
    track = Delivery.query.filter(Delivery.track_no == request.form['track_no'],Delivery.vendor==store.store_name).first()
    payment=request.form['payment'] #gcash or cash
    orderlist = Delivery.query.filter(Delivery.track_no == request.form['track_no'], Delivery.response=='Accepted',Delivery.vendor==store.store_name).all()
    total_sum = sum(order.total for order in orderlist)
    
    print(request.form['payment'])
    refereance=request.form['ref_no']
    if payment== 'cash':
        refereance= 'None'
        
    date = datetime.now()
    remit = Remittance(track.track_no,track.vendor,total_sum, track.mop ,request.form['payment'],refereance,'pickup',0,date)
    for order in orderlist:
        order.mop=request.form['payment']
        
    db.session.add(remit)
    db.session.commit()
    
    data_to_copy = Delivery.query.filter(Delivery.track_no == track.track_no,Delivery.vendor==track.vendor).all()
    
    delivery_data = []
    for item in data_to_copy:
        delivery_data.append({
            'track_no': item.track_no,
            'customer_id': item.customer_id,
            'food_id': item.food_id,
            'vendor_id': store.user_id,
            'food_name': item.food_name,
            'vendor': item.vendor,
            'quantity': item.quantity,
            'price': item.price,
            'total': item.total,
            'mop': item.mop,
            'payment': item.payment,
            'location': item.location,
            'reponse': item.response,
            'food_ready': item.food_ready,
            'payment_stat': item.payment,
            'complete': item.complete,
            'errand_id': item.errand_id,
            'date_created': datetime.now()
        })

        # Use bulk_insert_mappings to insert the data in a single database operation
        db.session.bulk_insert_mappings(Complete_Delivery, delivery_data)
        
        foodlist=Food.query.filter(Food.id==item.food_id).first()
        foodlist.sold=int(foodlist.sold)+1
        
        print(foodlist.sold)
      
        # Commit the changes
        db.session.commit()
        
        # db.session.query(Cart).delete()
    remit_done=Remittance.query.filter(Remittance.track_no==track.track_no,Remittance.vendor_name==store.store_name).first()
    db.session.delete(remit_done)
    db.session.commit()
    
    criteria = (Delivery.track_no == track.track_no,Delivery.vendor==track.vendor)  # Example filter criteria
            # Create a query object and apply the filter
    query = db.session.query(Delivery).filter(*criteria)
    query.delete()
    
    #here
    
            # Commit the changes
    db.session.commit()

    count=Delivery.query.filter(Delivery.vendor == store.store_name).with_entities(Delivery.track_no).distinct().count()
    remit_count=Remittance.query.filter_by(vendor_name=store.store_name).count()
    return render_template("Vendor/vendor_pending_order.html",count=count,store=store,user=user,remit_count=remit_count)

@_route_vendor.route('/vendor_complete',methods=['POST','GET'])
def vendor_complete():
 
    store=Vendor.query.filter_by(id=request.form['vendor_id']).first()
    user=User.query.filter_by(id=store.user_id).first()

    track = Delivery.query.filter(Delivery.track_no == request.form['track_no']).first()
    
 
    data_to_copy = Delivery.query.filter(Delivery.track_no == track.track_no,Delivery.vendor==track.vendor).all()
    remit_done=Remittance.query.filter(Remittance.track_no==track.track_no,Remittance.vendor_name==store.store_name).first()

    delivery_data = []
    for item in data_to_copy:
        delivery_data.append({
            'track_no': item.track_no,
            'customer_id': item.customer_id,
            'food_id': item.food_id,
            'vendor_id': store.user_id,
            'food_name': item.food_name,
            'vendor': item.vendor,
            'quantity': item.quantity,
            'price': item.price,
            'total': item.total,
            'mop': remit_done.payment,
            'payment': item.payment,
            'location': item.location,
            'reponse': item.response,
            'food_ready': item.food_ready,
            'payment_stat': item.payment,
            'complete': item.complete,
            'errand_id': item.errand_id,
            'date_created': datetime.now()
        })
        
        

        # Use bulk_insert_mappings to insert the data in a single database operation
        db.session.bulk_insert_mappings(Complete_Delivery, delivery_data)
        
        foodlist=Food.query.filter(Food.id==item.food_id).first()
        foodlist.sold=int(foodlist.sold)+1
        
        print(foodlist.sold)
      
        # Commit the changes
        db.session.commit()
        
        # db.session.query(Cart).delete()
    db.session.delete(remit_done)
    db.session.commit()
    
    criteria = (Delivery.track_no == track.track_no,Delivery.vendor==track.vendor)  # Example filter criteria
            # Create a query object and apply the filter
    query = db.session.query(Delivery).filter(*criteria)
     
        
    query.delete()
    
            # Commit the changes
    db.session.commit()
    
    track1 = Complete_Delivery.query.filter(Complete_Delivery.track_no == request.form['track_no']).first()

    date = datetime.now()
    fe=Fee.query.first()
    fee = Remittance.query.filter(Remittance.track_no == request.form['track_no']).with_entities(Remittance.vendor_name).distinct().count()
    print(fee)
    total_sum=0
    if fee>1:
        fee=(5*fee)-5
        fee1=Fee.query.first()
        total_sum=  fee1.fees + fee
    else: 
        fee1=Fee.query.first()
        total_sum=fee1.fees + total_sum
        
    print(total_sum)
            
    remit1 = Errand_sales(track.track_no,remit_done.df, track1.mop ,track1.payment,track1.errand_id,date)

    db.session.add(remit1)
    db.session.commit()
    
    remit_money=Remittance.query.filter_by(vendor_name=store.store_name).all()
    count=Delivery.query.filter(Delivery.vendor == store.store_name).with_entities(Delivery.track_no).distinct().count()
    remit_count=Remittance.query.filter_by(vendor_name=store.store_name).count()
    return render_template("Vendor/vendor_transaction.html",count=count,store=store,user=user,remit_money=remit_money,remit_count=remit_count)


@_route_vendor.route('/vendor_profile',  methods=['POST','GET'])
def vendor_profile():
        store=Vendor.query.filter_by(id=request.form['vendor_id']).first()
        user=User.query.filter_by(id=store.user_id).first()
        return render_template("Vendor/vendor_profile.html",user=user,store=store)
    

@_route_vendor.route('/vendor_profile_edit',  methods=['POST','GET'])
def vendor_profile_edit():
        store=Vendor.query.filter_by(id=request.form['vendor_id']).first()
        user=User.query.filter_by(id=store.user_id).first()
        
        fname = None
        if 'file' in request.files:
            fname = handle_profile_submition(request.files['file'])
            if fname is None:
                print("error")
        store.store_name=request.form['store_name']
        user.first_name=request.form['first_name']
        user.last_name=request.form['last_name']
        user.middle_name=request.form['middle_name']
        user.contact=request.form['contact']
        user.email=request.form['email']
        user.password=generate_password_hash(request.form['password'])
        #user.image_url=f"/{USER_CONTENT_FOLDER}/{fname}"
        #EDIT image
        image_full=os.path.join(USER_CONTENT_FOLDER, fname)

        # Find the index of "usercont" in the path
        index_of_usercont = image_full.find("usercont")

        # Extract the part of the path starting from "usercont"
        user.image_url = image_full[index_of_usercont:]
        db.session.commit()
        
        
        return render_template("Vendor/vendor_profile.html",user=user,store=store)

@_route_vendor.route('/usercont/<path:file>')
def serve_usercont(file):
    return send_from_directory(os.path.abspath(USER_CONTENT_FOLDER), file)

def gen_random_fname(length = 32):
    src = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    return ''.join([src[random.randint(0, len(src) - 1)] for x in range(0, length)])


def handle_profile_submition(file):
    if file.filename == '':
        return None
    fname = f"{gen_random_fname()}{os.path.splitext(file.filename)[1]}"
    file.save(os.path.join(USER_CONTENT_FOLDER, fname))
    return fname 