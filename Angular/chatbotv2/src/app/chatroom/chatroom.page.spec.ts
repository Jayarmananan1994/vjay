import { CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ChatroomPage } from './chatroom.page';

describe('ChatroomPage', () => {
  let component: ChatroomPage;
  let fixture: ComponentFixture<ChatroomPage>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ChatroomPage ],
      schemas: [CUSTOM_ELEMENTS_SCHEMA],
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ChatroomPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
